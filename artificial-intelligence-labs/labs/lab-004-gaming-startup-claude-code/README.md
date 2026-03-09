# Lab 004 - Gaming Startup de Sucesso com Claude Code

## Objetivo

Mostrar a capacidade de agentes de IA em criar jogos funcionais com governança de contexto, plan-mode, skills e MCP.

## Dificuldade e tempo

- Dificuldade: Avançado
- Tempo estimado: 60 a 90 minutos

## Propósito

Demonstrar que, com boas práticas (context engineering e especificação), os resultados superam o vibe coding.

## Pré-requisitos

- Conta Claude: https://claude.ai/
- Claude Code: https://claude.com/product/claude-code
- VS Code instalado
- Acesso a terminal

## Passo a passo

1. Crie um projeto novo:

```bash
mkdir my-new-claude-gta-project && cd my-new-claude-gta-project
```

2. Inicie o Claude Code:

```bash
claude
```

3. Faça login pela opção de API e conecte a IDE:

```text
ide
```

4. Use o comando do Claude para configurar MCPs (`mcp`).
5. Se já tiver MCPs no VS Code/Cursor, peça para o Claude reaproveitar a configuração.
6. Consulte o cheatsheet: https://awesomeclaude.ai/code-cheatsheet
7. Adicione skills relevantes (fortemente recomendado): https://claude-plugins.dev/skills
8. Priorize skills de arquitetura de software, engenharia sênior e desenvolvimento de jogos.

## Prompt de comparação (igual ao Lab 002 - Prompt Médio)

Use somente este prompt para reduzir complexidade e comparar os primeiros resultados entre Lab 002, Lab 004 e Lab 005.

### Prompt único

```text
Crie um código HTML5/JS único de um clone de Angry Birds utilizando Matter.js. O jogo deve ter física de estilingue manual (arrastar/soltar responsivo), sistema de destruição estrutural realista (blocos e porcos com HP/Partículas) e renderização vetorial completa via Canvas (Pássaro, Porcos, Cenário), sem imagens externas.
```

## Execução no Claude Code

1. Rode em plan-mode (Shift+Tab).
2. Cole o prompt único exatamente como está acima.
3. Gere o `index.html`.
4. Teste o `index.html` no navegador jogando de verdade.
5. Sempre que encontrar falha (física do estilingue, bug, travamento, UX), descreva em linguagem natural no prompt o que deu errado.
6. Peça para o Claude corrigir e regenerar o código.
7. Repita o ciclo testar → reportar problema → corrigir até obter experiência jogável estável.

## Validação guiada

- O projeto foi iniciado com Claude Code em plan-mode.
- MCPs e skills foram configurados no fluxo.
- O lab utilizou apenas o prompt único de Angry Birds.
- O `index.html` foi testado após cada implementação.
- Houve iterações de correção baseadas em feedback em linguagem natural do usuário.
- Critério funcional: o jogo inicia sem erro fatal, responde a inputs e mantém loop jogável por pelo menos 2 minutos.
- Critério de performance: sem travamentos severos, com experiência minimamente fluida durante a execução.
