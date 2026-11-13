# Runbook: pedidos-api indisponível ou com erro no proxy

**Escopo:** projeto Docker Compose `tbx-aiops-linux` (proxy Nginx + backend pedidos-api) do lab 006.
**Configuração do proxy:** `../../lab-006-linux-troubleshooting-ia/workspace/nginx/default.conf`
**Pode consultar:** containers, logs e configuração desse projeto. **Pode mudar (com aprovação):** só a configuração do proxy.

## 1. Coletar
Rode `bash scripts/coleta.sh`. Ele mostra estado dos containers, código HTTP de `/health`, últimas linhas de log do proxy e o destino do `proxy_pass`.

## 2. Interpretar
| O que a coleta mostra | Conclusão | Próximo passo |
|---|---|---|
| `/health` = 200 e containers `running` | serviço saudável | **encerrar sem mudar nada** e registrar |
| `/health` = 502, backend `healthy`, log com `connect() failed` | proxy apontando para destino errado | comparar o `proxy_pass` com a porta em que o backend escuta (`backend/app.py`) e ir ao passo 3 |
| containers parados ou ausentes, `/health` sem resposta | ambiente indisponível | **não inventar diagnóstico**: relatar o bloqueio e escalar para quem opera o ambiente |

## 3. Corrigir (exige aprovação)
- Propor o ajuste exato no `proxy_pass` e **esperar aprovação**.
- Depois da aprovação: editar a configuração e recarregar com `docker compose -p tbx-aiops-linux exec proxy nginx -s reload`.
- Não reiniciar o backend, não publicar a porta do backend e não contornar o proxy.

## 4. Verificar e registrar
- Rodar `bash scripts/coleta.sh` de novo: `/health` deve voltar a 200.
- Registrar em `registros/AAAA-MM-DD-HHMM.md`: estado inicial, evidências, o que mudou e a verificação. Se algo não pôde ser verificado, dizer isso.
