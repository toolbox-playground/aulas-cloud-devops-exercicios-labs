# Lab 006 - Troubleshooting de serviço Linux com agente de IA

## Objetivo

Subir um proxy Nginx na frente de um backend, quebrar o proxy de propósito e pedir ao **Claude Code** ou ao **Codex**, na CLI, que investigue, encontre a causa com evidências, proponha a correção e só aplique depois da sua aprovação.

Quem executa os comandos de diagnóstico é o agente. Você descreve o sintoma, acompanha o loop dele (roda → lê a saída → decide o próximo passo) e aprova a mudança.

## Dificuldade e tempo

- Dificuldade: Intermediário
- Tempo estimado: 12 a 18 minutos (sem contar o download das imagens)

## Arquitetura

```text
você (curl) ──► 127.0.0.1:18080 ──► proxy (nginx:1.27-alpine) ──► backend:8000 (python:3.12-alpine)
```

- Projeto Docker Compose exclusivo: `tbx-aiops-linux`.
- Só o proxy publica porta, e só em `127.0.0.1:18080`.
- A configuração do Nginx fica em `workspace/nginx/default.conf`, montada no container.

## Pré-requisitos

| Ferramenta | Como conferir |
|---|---|
| Docker Desktop (macOS/Windows) ou Docker Engine (Linux), rodando | `docker info` |
| Docker Compose v2 | `docker compose version` |
| curl | `curl --version` |
| Claude Code **ou** Codex instalado e autenticado | `claude --version` ou `codex --version` |

No Windows, rode os comandos no WSL2 (Ubuntu) ou no Git Bash.

**Antes de gravar** (para o download não aparecer no vídeo):

```bash
docker pull nginx:1.27-alpine
docker pull python:3.12-alpine
```

## Passo a passo

### 1. Subir o ambiente saudável

Entre na pasta do lab e suba o proxy e o backend. O script só termina com sucesso se o `/health` responder `200 ok` pelo proxy.

```bash
cd artificial-intelligence-labs/labs/lab-006-linux-troubleshooting-ia
bash scripts/setup.sh --state healthy
curl -i http://127.0.0.1:18080/health
```

Resultado esperado: `HTTP/1.1 200 OK` e corpo `ok`.

### 2. Provocar a falha

O script injeta **uma** falha no proxy e confirma o sintoma: o `curl` passa a devolver `502 Bad Gateway`, enquanto o backend continua saudável.

```bash
bash scripts/inject-fault.sh upstream-port
curl -i http://127.0.0.1:18080/health
```

### 3. Abrir o agente dentro do workspace

Abra uma sessão **nova** do agente na pasta `workspace/` (é lá que ficam o Compose e a configuração).

```bash
cd workspace
claude        # Claude Code
# ou
codex         # Codex
```

### 4. Pedir o troubleshooting

Cole o pedido abaixo:

```text
Este ambiente de laboratório tem um proxy e um backend, rodando com Docker Compose neste diretório.
A URL http://127.0.0.1:18080/health está falhando. Investigue o workspace e o ambiente em execução,
inicialmente sem alterar nada. Mostre a evidência da causa e proponha a menor correção.
Aguarde minha confirmação antes de aplicá-la. Trabalhe apenas neste projeto; depois confirme o
funcionamento pela mesma URL.
```

Acompanhe o que o agente faz. Os comandos de leitura (`docker compose ps`, `docker compose logs`, ler a configuração, `curl`) são o loop de investigação dele. Antes de editar arquivo ou recarregar o Nginx, ele deve parar e pedir aprovação, conforme o modo de permissão.

O que o agente deve encontrar no loop dele:

- `curl` → `HTTP/1.1 502 Bad Gateway`
- `docker compose logs proxy` → `connect() failed (111: Connection refused) while connecting to upstream ... upstream: "http://...:8001/health"`
- `nginx/default.conf` → `proxy_pass http://backend:8001;`
- `backend/app.py` → o backend escuta na porta **8000**; `docker compose ps` mostra o backend `healthy`

Causa: o proxy encaminha para a porta 8001, mas o backend escuta na 8000.

### 5. Aprovar e conferir

Quando o agente parar e propor voltar o `proxy_pass` para `backend:8000`, aprove:

```text
Aprovado. Aplique só essa correção, recarregue o proxy e confirme pela mesma URL.
```

Se ele tentar contornar o problema (publicar a porta do backend, chamar o backend direto ou mudar a porta do backend), recuse:

```text
Não quero expor o backend nem pular o proxy. Corrija a configuração do proxy para que ele
encaminhe para o backend corretamente.
```

Depois, confira pelo mesmo caminho que falhava (saia do agente antes: `/exit` no Claude Code, `Ctrl+C` no Codex):

```bash
cd ..
bash scripts/verify.sh --state healthy
```

### 6. Repetir ou limpar

```bash
bash scripts/reset.sh --state broken   # volta ao defeito para gravar de novo
bash scripts/teardown.sh               # remove só os containers deste lab
```

## Critério de conclusão

- A causa foi mostrada com evidência (log do proxy, configuração e porta do backend).
- A correção mexeu só no destino do proxy, sem pular o proxy nem expor outra porta.
- `bash scripts/verify.sh --state healthy` passa: proxy e backend ativos, `/health` → `200 ok`.

## Referências

- [Nginx: proxy_pass](https://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_pass)
- [Docker Compose](https://docs.docker.com/compose/)
- Aula 04-2 do curso: troubleshooting Linux com agente.
