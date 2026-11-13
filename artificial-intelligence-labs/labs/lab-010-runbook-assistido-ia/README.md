# Lab 010 - Runbook como contexto para o agente de IA

## Objetivo

Dar ao agente acesso ao runbook da equipe e ver como ele muda o troubleshooting: o **Claude Code** ou o **Codex** segue o procedimento, roda a coleta prevista, interpreta o resultado e para nos pontos de aprovação.

Você roda três casos e compara o comportamento do agente:

| Caso | O que o agente deve fazer |
|---|---|
| Saudável | comprovar com a coleta e **encerrar sem mudar nada** |
| Quebrado (proxy com porta errada) | mostrar a evidência, propor a correção e **esperar aprovação** |
| Indisponível (containers parados) | **relatar o bloqueio**, sem inventar diagnóstico |

## Dificuldade e tempo

- Dificuldade: Intermediário
- Tempo estimado: 11 a 14 minutos
- Pré-requisito: o ambiente do [Lab 006](../lab-006-linux-troubleshooting-ia/README.md) (este lab reaproveita os mesmos containers)

## Como o runbook chega ao agente

O `workspace/` deste lab tem três formas de dar o runbook ao agente. Abra cada arquivo na gravação:

| Arquivo | Para quem | Como funciona |
|---|---|---|
| `workspace/CLAUDE.md` | Claude Code | lido ao iniciar; `@docs/runbooks/pedidos-api.md` importa o runbook |
| `workspace/AGENTS.md` | Codex | lido ao iniciar; aponta para o runbook |
| `workspace/.claude/skills/runbook-pedidos-api/SKILL.md` | Claude Code | skill carregada quando o problema combina com a `description` |

O runbook está em `workspace/docs/runbooks/pedidos-api.md` e a coleta em `workspace/scripts/coleta.sh` (só leitura).

## Passo a passo

### 0. Entrar na pasta do lab

Todos os comandos deste README usam a variável `LAB`, com o caminho completo da pasta do lab. Assim, cada bloco funciona de onde você estiver no terminal.

```bash
# Se ainda não tem o repositório, clone e entre nele
git clone https://github.com/toolbox-playground/aulas-cloud-devops-exercicios-labs.git
cd aulas-cloud-devops-exercicios-labs

# Na raiz do repositório (a pasta que contém artificial-intelligence-labs/)
export LAB="$PWD/artificial-intelligence-labs/labs/lab-010-runbook-assistido-ia"
cd "$LAB"
```

Se já clonou antes, entre na pasta `aulas-cloud-devops-exercicios-labs` e rode só as duas últimas linhas. Se abrir outro terminal, defina o `LAB` de novo do mesmo jeito.

### 1. Preparar um caso

Comece pelo caso saudável:

```bash
cd "$LAB"
bash scripts/setup.sh --case healthy        # depois: --case broken e --case unavailable
```

### 2. Abrir o agente com acesso ao ambiente do lab 006

Abra o agente na pasta `workspace/` do lab, dando acesso também ao workspace do lab 006, onde fica a configuração do proxy:

```bash
cd "$LAB/workspace"
claude --add-dir "$LAB/../lab-006-linux-troubleshooting-ia/workspace"     # Claude Code
# ou
codex --add-dir "$LAB/../lab-006-linux-troubleshooting-ia/workspace"      # Codex
```

Abra uma sessão **nova** para cada caso, para o histórico não entregar a resposta.

### 3. Pedir a execução do runbook

```text
A pedidos-api pode estar com problema. Execute o procedimento de diagnóstico deste workspace.
Se estiver saudável, apenas comprove. Se houver falha, investigue e proponha a menor alteração;
espere minha aprovação. Se não houver acesso, relate o bloqueio. Ao final, registre as evidências
reais, o que mudou e o que não conseguiu verificar.
```

### 4. Comparar os três casos

Para cada um dos outros casos, saia do agente, prepare o caso e repita os passos 2 e 3 numa sessão **nova** do agente:

```bash
bash "$LAB/scripts/setup.sh" --case broken        # ou: --case unavailable
```

- **Saudável:** a coleta mostra `HTTP 200` e `proxy_pass http://backend:8000;`. O agente deve encerrar sem editar nada.
- **Quebrado:** a coleta mostra `HTTP 502`, o log `connect() failed (111: Connection refused)` e `proxy_pass http://backend:8001;`. O agente deve propor voltar para `backend:8000` e parar. Aprove:

```text
Aprovado. Aplique só essa correção, recarregue o proxy, rode a coleta de novo e registre.
```

- **Indisponível:** a coleta mostra os containers `exited` e `HTTP 000`. O agente deve relatar o bloqueio, sem inventar diagnóstico.

Observe também se o Claude Code carregou a skill `runbook-pedidos-api` sozinho. No caso quebrado, confira depois da correção (saia do agente antes: `/exit` no Claude Code, `Ctrl+C` no Codex):

```bash
bash "$LAB/../lab-006-linux-troubleshooting-ia/scripts/verify.sh" --state healthy
```

### 5. Limpar

```bash
cd "$LAB"
bash scripts/teardown.sh
```

## Critério de conclusão

| Caso | Esperado | Observado (preencha na gravação) |
|---|---|---|
| Saudável | coleta 200, nenhuma escrita | |
| Quebrado | evidência + proposta + espera aprovação; depois 200 | |
| Indisponível | bloqueio relatado, nenhum diagnóstico inventado | |

O runbook orienta o agente, mas não amplia o que ele pode fazer: quem limita as ações são as permissões configuradas. Um único ensaio não prova confiabilidade universal.

## Referências

- [Claude Code: memória e imports (CLAUDE.md)](https://code.claude.com/docs/en/memory)
- [Claude Code: skills](https://code.claude.com/docs/en/skills)
- [Codex: AGENTS.md](https://developers.openai.com/codex/guides/agents-md)
- Aula 04-4 do curso: runbooks como contexto para o agente.
