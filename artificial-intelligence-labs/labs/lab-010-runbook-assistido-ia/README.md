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

### 1. Preparar um caso

Rode a partir da pasta deste lab. Comece pelo saudável:

```bash
cd artificial-intelligence-labs/labs/lab-010-runbook-assistido-ia
bash scripts/setup.sh --case healthy        # depois: --case broken e --case unavailable
```

### 2. Abrir o agente com acesso ao ambiente do lab 006

O agente roda em `workspace/` deste lab e recebe acesso à pasta do lab 006, onde fica a configuração do proxy.

```bash
cd workspace
claude --add-dir ../../lab-006-linux-troubleshooting-ia/workspace     # Claude Code
# ou
codex --add-dir ../../lab-006-linux-troubleshooting-ia/workspace      # Codex
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

Repita os passos 1 a 3 com `--case broken` e `--case unavailable`. No caso quebrado, aprove a correção e confira:

```bash
bash ../../lab-006-linux-troubleshooting-ia/scripts/verify.sh --state healthy
```

### 5. Limpar

```bash
cd ..
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
