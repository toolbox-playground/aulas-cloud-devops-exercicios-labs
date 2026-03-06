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
7. Adicione skills relevantes: https://claude-plugins.dev/skills

## Prompts de comparação (exatamente iguais ao Lab 002)

Use os prompts abaixo sem alterações para comparar os primeiros resultados entre Lab 002, Lab 004 e Lab 005.

### Prompt 1 - Fácil

```text
Crie um sistema solar dinâmico em HTML/CSS/JS: planetas orbitando um sol brilhante com texturas únicas e luminosidade atmosférica. Inclua luas, cinturões de asteroides, cometas ocasionais e movimentos sutis de câmera. A cena deve se repetir perfeitamente com órbitas e iluminação suaves.
```

### Prompt 2 - Médio

```text
Crie um código HTML5/JS único de um clone de Angry Birds utilizando Matter.js. O jogo deve ter física de estilingue manual (arrastar/soltar responsivo), sistema de destruição estrutural realista (blocos e porcos com HP/Partículas) e renderização vetorial completa via Canvas (Pássaro, Porcos, Cenário), sem imagens externas.
```

### Prompt 3 - Difícil

```text
Programar um protótipo de "GTA 6" com mundo aberto, carros e personagens 3D usando apenas HTML, CSS e JavaScript (Three.js) em um arquivo único. Coisas para considerar: Jogabilidade, Gráficos e Atmosfera, Lógica de Código, A Interface. O protótipo precisa ser 100% jogável através do navegador, como se fosse GTA.
```

## Execução no Claude Code

1. Rode em plan-mode (Shift+Tab).
2. Cole cada prompt exatamente como está acima.
3. Gere saída executável e faça testes no navegador.
4. Itere melhorias apenas após registrar o resultado inicial para comparação.

## Validação guiada

- O projeto foi iniciado com Claude Code em plan-mode.
- MCPs e skills foram configurados no fluxo.
- Critério funcional: o jogo inicia sem erro fatal, responde a inputs e mantém loop jogável por pelo menos 2 minutos.
- Critério de performance: sem travamentos severos, com experiência minimamente fluida durante a execução.
