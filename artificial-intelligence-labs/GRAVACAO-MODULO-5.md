# Módulo 5 · roteiro de gravação (vídeo único)

Curso **IA para Desenvolvimento e Operação de Software**. O módulo 5 é prático: você executa os labs abaixo na sua máquina, com fala espontânea, num vídeo único. Em todos, quem investiga e executa os comandos é o agente (**Claude Code** ou **Codex**); você descreve o problema, acompanha o loop e aprova o que muda o ambiente.

## Antes de apertar o REC (fora da gravação)

Baixe as imagens e o provider para o download não aparecer no vídeo:

```bash
docker pull nginx:1.27-alpine
docker pull python:3.12-alpine
docker pull curlimages/curl:8.11.1
```

A imagem do nó do kind é baixada no primeiro `kind create cluster`; por isso vale criar o cluster do lab 007 antes de gravar.

- Feche containers pesados que não fazem parte dos labs: o kind precisa de CPU livre para subir o control plane.
- Confira `claude --version` / `codex --version` e o login do agente.
- Opcional: crie o cluster do lab 007 antes (`bash scripts/setup.sh --state healthy`) e grave só a partir da falha.

## Ordem sugerida

| Bloco | Lab | O que mostra | Tempo |
|---|---|---|---|
| 1 | [006 · Linux](labs/lab-006-linux-troubleshooting-ia/README.md) | proxy Nginx com porta errada (502) → agente investiga logs/config → aprovação → 200 | 12–18 min |
| 2 | [010 · Runbook como contexto](labs/lab-010-runbook-assistido-ia/README.md) | mesmo ambiente, agora com runbook no CLAUDE.md/AGENTS.md/skill: saudável, quebrado e indisponível | 11–14 min |
| 3 | [007 · Kubernetes](labs/lab-007-kubernetes-troubleshooting-ia/README.md) | Service com selector errado → agente compara labels/selector/EndpointSlice → corrige o manifesto | 12–18 min |
| 4 | [011 · Terraform](labs/lab-011-terraform-troubleshooting-ia/README.md) | plan quebrado por refactor → correção; depois mudança que destrói recurso → loop do plan | 10–15 min |
| 5 | [009 · Documentos + MCP](labs/lab-009-contexto-documentos-mcp/README.md) | respostas com fonte, documento antigo, instrução escondida; chamada real a um MCP | 10–15 min |
| 6 | [008 · Do layout ao PR](labs/lab-008-desenvolvimento-validacao-ia/README.md) | proposta de layout → implementação → teste no navegador → ajuste → testes → PR | 15–20 min |

## Padrão de cada bloco

1. **Setup** do lab (estado saudável) e uma frase sobre a arquitetura.
2. **Injetar a falha** com o script e mostrar o sintoma (curl, plan, kubectl).
3. **Sessão nova** do agente dentro de `workspace/` (o gabarito `INSTRUCTOR.md` fica fora dela).
4. **Colar o prompt** de `prompts.md` e comentar o loop: qual comando o agente escolheu, o que leu, o que decidiu.
5. **Aprovar** a mudança quando ele parar para pedir.
6. **Verificar** com o script `verify.sh --state healthy` (ou o critério do lab).
7. `reset.sh` para outra tomada ou `teardown.sh` no fim.

Claude Code e Codex podem seguir caminhos diferentes. O que vale é causa, escopo e resultado, não a sequência exata de comandos.
