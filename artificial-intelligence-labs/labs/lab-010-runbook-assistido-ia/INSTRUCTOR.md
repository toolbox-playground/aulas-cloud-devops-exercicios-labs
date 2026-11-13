# Lab 010 · guia do instrutor

## Casos e o que a coleta mostra (ensaio real, 13/11/2026)

| Caso | `scripts/setup.sh` | Saída da coleta |
|---|---|---|
| Saudável | lab 006 `--state healthy` | containers `running`, `HTTP 200`, `proxy_pass http://backend:8000;` |
| Quebrado | lab 006 `--state broken` | `HTTP 502`, log `connect() failed (111: Connection refused) ... upstream: "http://172.22.0.2:8001/health"`, `proxy_pass http://backend:8001;` |
| Indisponível | lab 006 saudável + `docker compose -p tbx-aiops-linux stop` | containers `exited`, `HTTP 000`, "(proxy indisponível: não foi possível ler a configuração em execução)" |

Só os containers do projeto `tbx-aiops-linux` são parados. Nunca pare o Docker inteiro para simular indisponibilidade.

## Gabarito do caso quebrado

Mesma causa do lab 006: `proxy_pass` em `backend:8001`, backend escutando em `8000`. Correção: voltar para `backend:8000` em `lab-006-linux-troubleshooting-ia/workspace/nginx/default.conf` e recarregar o proxy.

## O que observar na gravação

- Se o Claude Code carregou a skill `runbook-pedidos-api` sozinho ou leu o runbook pelo `CLAUDE.md`.
- No saudável: nenhuma edição de arquivo.
- No quebrado: parada antes de editar; edição só do `proxy_pass` depois da aprovação; coleta repetida com 200; registro em `registros/`.
- No indisponível: o agente relata containers parados e não "corrige" nada. Ele pode sugerir subir o ambiente: isso é proposta, não ação autorizada.

## Sequência de gravação

1. Mostrar `docs/runbooks/pedidos-api.md`, `CLAUDE.md`, `AGENTS.md` e a skill.
2. Caso saudável → sessão nova → prompt.
3. Caso quebrado → sessão nova → prompt → aprovar → `verify.sh --state healthy` do lab 006.
4. Caso indisponível → sessão nova → prompt.
5. Preencher a tabela do README e rodar `teardown.sh`.
