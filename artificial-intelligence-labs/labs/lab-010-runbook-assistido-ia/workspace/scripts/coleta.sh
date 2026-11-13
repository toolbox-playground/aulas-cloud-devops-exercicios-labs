#!/usr/bin/env bash
# Coleta do runbook pedidos-api: só leitura. Não altera nada.
P="tbx-aiops-linux"
echo "## containers do projeto $P"
docker ps -a --filter "label=com.docker.compose.project=$P" --format '{{.Label "com.docker.compose.service"}}\t{{.State}}\t{{.Status}}' || true
echo
echo "## GET http://127.0.0.1:18080/health"
code="$(curl -s -o /dev/null -m 3 -w '%{http_code}' http://127.0.0.1:18080/health || true)"
echo "HTTP ${code:-000}"
echo
echo "## últimas linhas de log do proxy"
docker compose -p "$P" logs --no-color --tail 3 proxy 2>&1 || echo "(sem logs: proxy indisponível)"
echo
echo "## destino configurado no proxy"
docker compose -p "$P" exec -T proxy grep -h proxy_pass /etc/nginx/conf.d/default.conf 2>/dev/null || echo "(proxy indisponível: não foi possível ler a configuração em execução)"
