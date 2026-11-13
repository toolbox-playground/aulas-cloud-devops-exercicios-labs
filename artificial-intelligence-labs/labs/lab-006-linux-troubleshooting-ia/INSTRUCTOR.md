# Lab 006 · guia do instrutor (gabarito)

> Não mostre este arquivo na gravação antes de o agente concluir. O agente trabalha em `workspace/`; o gabarito fica fora dele (não é barreira de segurança, só evita entregar a resposta).

## Falha injetada

`scripts/inject-fault.sh upstream-port` troca, em `workspace/nginx/default.conf`, `proxy_pass http://backend:8000;` por `proxy_pass http://backend:8001;` e recarrega o Nginx. O backend continua escutando na **8000**.

## Evidências que o agente deve encontrar (ensaio real, 13/11/2026)

```text
$ curl -i http://127.0.0.1:18080/health
HTTP/1.1 502 Bad Gateway

$ docker compose logs proxy
[error] ... connect() failed (111: Connection refused) while connecting to upstream, ...
upstream: "http://172.22.0.2:8001/health"

$ grep -n proxy_pass nginx/default.conf
6:        proxy_pass http://backend:8001;

$ docker compose ps
backend   Up (healthy)
proxy     Up            127.0.0.1:18080->80/tcp
```

O backend responde em 8000 (`app.py` mostra `HTTPServer(("0.0.0.0", 8000), ...)`).

## Correção esperada

Voltar o destino para `backend:8000` e recarregar o proxy (`docker compose exec proxy nginx -s reload` ou `docker compose restart proxy`).

Não aceitar como solução: publicar a porta do backend, chamar o backend direto, trocar a arquitetura ou mudar a porta do backend para 8001 sem justificar.

## Sequência de gravação

1. Mostrar a arquitetura e rodar `setup.sh --state healthy` (200 ok).
2. Em momento separado, rodar `inject-fault.sh upstream-port` (502).
3. Abrir sessão **nova** do agente em `workspace/` e colar o prompt de `prompts.md`.
4. Comentar o loop: quais comandos ele escolheu, o que leu, o que decidiu.
5. Conferir que ele parou antes de editar; aprovar.
6. Rodar `verify.sh --state healthy`.
7. `reset.sh --state broken` para outra tomada, ou `teardown.sh` no fim.

## Ensaio dos scripts (13/11/2026, macOS, Docker Desktop, Compose v2.32)

| Etapa | Resultado observado |
|---|---|
| `setup.sh --state broken` | saudável 200 `ok` → falha injetada → 502 com backend saudável (~65 s, inclui download) |
| Correção manual do upstream + reload | `verify.sh --state healthy` passou |
| `reset.sh --state broken` | voltou a 502 |
| `teardown.sh` | containers e rede `tbx-aiops-linux` removidos; configuração saudável restaurada |

Claude Code ou Codex podem seguir caminhos diferentes. Avalie causa, escopo e resultado, não a sequência exata de comandos.
