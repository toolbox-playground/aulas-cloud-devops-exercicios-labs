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
mkdir my-new-claude-angrybirds-project && cd my-new-claude-angrybirds-project
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
7. Adicione plugins e skills relevantes (fortemente recomendado): https://claude-plugins.dev/skills e https://claude.com/plugins#plugins
8. Priorize plugins e skills de arquitetura de software, engenharia sênior e desenvolvimento de jogos.

### Pré-prompts (antes do prompt único)

Use estes prompts para guiar o agente antes de iniciar a fase de implementação.

#### Pré-prompt 1 — Plugins e MCP

```text
Neste link https://claude.com/plugins#plugins há alguns plugins interessantes que quero baixar, como: Frontend Design, Context7, Feature Dev, Superpowers, Plugin Developer Toolkit, Playground, Code review, code simplifier, github, skill creator, claude.md management, claude code setup, pr review toolkit, .

Vejo muitos plugins... já os tenho instalados? Se não, liste todos e instale-os.
```

#### Pré-prompt 2 — Skills locais do projeto

```text
a partir do conhecimento adquirido nos plugins, crie skills locais no projeto atual para desenvolvimento de games html, css, javascript  e matter.js que rodem em browsers com física, jogabilidade e dinamica perfeita.
```

## Prompt de comparação (igual ao Lab 002 - Prompt Médio)

Use somente este prompt para reduzir complexidade e comparar os primeiros resultados entre Lab 002, Lab 004 e Lab 005.

### Prompt único

```text
crie um código index.html unico HTML5/JS único de um clone de Angry Birds utilizando Matter.js. Mas primeiro vamos criar a governança do seu projeto através da criação do arquivo  CLAUDE.md e de quaisquer skills locais que os agents julguem importantes ou pertinente ao projeto. Crie o repositorio local caso ainda não existe chamado my-new-claude-angrybirds-project, entre no repositorio e crie o claude.md e skills qeu ache necessario. Neste primeiro momento vamos apenas montar a governaça e esqueleto do projeto mas sem codar ainda. para contexto inicial, ojogo deve ter física de estilingue manual (arrastar/soltar responsivo), sistema de destruição estrutural realista (blocos e porcos com HP/Partículas) e renderização vetorial completa via Canvas (Pássaro, Porcos, Cenário), sem imagens externas.. Ao criar o claude e possiveis skills, defina que deve-se criar o código HTML5/JS único de um clone de Angry Birds utilizando Matter.js. O jogo deve ter física de estilingue manual (arrastar/soltar responsivo e seguindo lógica física de ação reação ou seja, puxar o estilingue deve haver a reação do passaro voar na direcao oposta), sistema de destruição estrutural realista (blocos e porcos com HP/Partículas) e renderização vetorial completa via Canvas (Pássaro, Porcos, Cenário), sem imagens externas. Use principios focados em DevOps, desenvolvimento de jogos em diversos frameworks comohtml, css e javascript,  com engines e bibliotecas que façam com que os jogos tenham alta qualidade, baixa complexidade sempre que possivel e alto desempenho. Mais importante o jogo deve ser fisicamente funcional, significando que a física de puxar o estilingue e o passarinho sofrer a ação da elasticidade (ação/reação) e a direção do estilingue devem fisicar fazer sentido e funcionar. Para andar mais rápido, vejo o que dá para paralelizar e delegue subagents rodando em paralelo pra dar mais agilidade a criacao.
```

## Execução no Claude Code

1. Rode em plan-mode (Shift+Tab).
2. Execute os dois pré-prompts (plugins/MCP e skills locais).
3. Cole o prompt único exatamente como está acima.
4. Valide que a primeira saída foca em governança (`CLAUDE.md` + skills + esqueleto do projeto), sem implementar o jogo completo ainda.
5. Após a governança, avance para a implementação do `index.html`.
6. Teste o `index.html` no navegador jogando de verdade.
7. Sempre que encontrar falha (física do estilingue, bug, travamento, UX), descreva em linguagem natural no prompt o que deu errado.
8. Peça para o Claude corrigir e regenerar o código.
9. Repita o ciclo testar → reportar problema → corrigir até obter experiência jogável estável.

## Validação guiada

- O projeto foi iniciado com Claude Code em plan-mode.
- MCPs, plugins e skills foram configurados no fluxo.
- O lab utilizou pré-prompts e prompt único de Angry Birds.
- A etapa de governança foi concluída antes da codificação principal.
- O `index.html` foi testado após cada implementação.
- Houve iterações de correção baseadas em feedback em linguagem natural do usuário.
- Critério funcional: o jogo inicia sem erro fatal, responde a inputs e mantém loop jogável por pelo menos 2 minutos.
- Critério de performance: sem travamentos severos, com experiência minimamente fluida durante a execução.

## Referências

- Claude: https://claude.ai/
- Claude Code: https://claude.com/product/claude-code
- Claude Code Cheatsheet: https://awesomeclaude.ai/code-cheatsheet
- Claude Skills/Plugins: https://claude-plugins.dev/skills
- Matter.js: https://brm.io/matter-js/
