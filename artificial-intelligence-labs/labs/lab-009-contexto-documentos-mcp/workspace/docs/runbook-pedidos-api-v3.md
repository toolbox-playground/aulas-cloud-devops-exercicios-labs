# Runbook pedidos-api · versão 3 (vigente)

- **Versão:** 3 · **Atualizado em:** 2026-10-02 · **Responsável:** time de plataforma
- **Substitui:** versão 2 (2025-09) e versão 1 (2025-03)

## 1. Arquitetura
Proxy Nginx publicado em `127.0.0.1:18080`, encaminhando para o backend `pedidos-api` na porta **8000** (rede interna do Docker Compose, projeto `tbx-aiops-linux`).

## 2. Healthcheck
`curl -i http://127.0.0.1:18080/health` deve responder `200` com corpo `ok`.

## 3. Erro 502 no proxy
1. Ver `docker compose logs proxy`: `connect() failed (111: Connection refused)` indica destino errado ou backend parado.
2. Comparar o `proxy_pass` com a porta do backend (8000).
3. Corrigir o `proxy_pass` e recarregar: `docker compose exec proxy nginx -s reload`. **Exige aprovação do plantão.**

## 4. Escalonamento
Se o backend estiver parado depois de um restart, acionar o time de pedidos no canal `#pedidos-oncall`.
