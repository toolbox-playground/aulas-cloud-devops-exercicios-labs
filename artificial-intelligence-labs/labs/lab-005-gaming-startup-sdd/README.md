# Lab 005 - Gaming Startup de Sucesso com SDD

## Objetivo

Construir um jogo com abordagem Specification-Driven Development (SDD), com governança, planejamento e implementação orientada por especificações.

## Dificuldade e tempo

- Dificuldade: Avançado
- Tempo estimado: 70 a 100 minutos

## Propósito

Mostrar como SDD reduz caos de vibe coding e aumenta previsibilidade, qualidade e manutenção do projeto.

## Pré-requisitos

- VS Code + Claude Code ou Copilot ou Cursor
- Ambiente com Spec Kit/SDD
- Referência: https://developer.microsoft.com/blog/spec-driven-development-spec-kit

## Passo a passo

1. Estude rapidamente o framework SDD (Spec Kit).
2. Inicialize projeto:

```bash
specify init my-project-sdd --integration claude
cd my-project-sdd
```

3. Entre no projeto no VS Code.
4. Defina a constituição de engenharia no chat.
5. Especifique o produto (jogo), gere plano, refine e implemente.


## Pré-prompts 

Use estes prompts para guiar o agente antes de iniciar a fase de implementação.

### Pré-prompt 1 — Plugins e MCP

```text
Neste link https://claude.com/plugins#plugins há alguns plugins interessantes que quero baixar, como: Frontend Design, Context7, Feature Dev, Superpowers, Plugin Developer Toolkit, Playground, Code review, code simplifier, github, skill creator, claude.md management, claude code setup, pr review toolkit, .

Vejo muitos plugins... já os tenho instalados? Se não, liste todos e instale-os.
```

### Pré-prompt 2 — Skills locais do projeto

```text
/superpowers:using-superpowers a partir do conhecimento adquirido nos plugins, como frontend, canva e suporpoweres, crie skills locais no projeto atual para desenvolvimento de games html, css, javascript  e matter.js que rodem em browsers com física, jogabilidade e dinamica perfeita.
```

## Execução com SDD

Agora ao invés de um prompt único, como nos laborátorios passados, vamos executar mais prompts a fim de criar o esqueleto do projeto que guiará o LLM na correta execução e implementação do código.

1. Defina a constituição do projeto:

```text
/speckit.constitution crie princípios focados em DevOps, desenvolvimento de jogos em diversos frameworks como python pygame ou html, css e javascript, com engines e bibliotecas que façam com que os jogos tenham alta qualidade como matter.js, baixa complexidade sempre que possível e alto desempenho.
```

2. Execute `/speckit.specify` usando exatamente o texto do prompt único.
    ```text
    crie um código index.html unico HTML5/JS único de um clone de Angry Birds utilizando Matter.js. Mas primeiro vamos criar a governança do seu projeto através da criação do arquivo  CLAUDE.md e de quaisquer skills locais que os agents julguem importantes ou pertinente ao projeto. Crie o repositorio local caso ainda não existe chamado my-new-claude-angrybirds-project, entre no repositorio e crie o claude.md e skills qeu ache necessario. Neste primeiro momento vamos apenas montar a governaça e esqueleto do projeto mas sem codar ainda. para contexto inicial, ojogo deve ter física de estilingue manual (arrastar/soltar responsivo), sistema de destruição estrutural realista (blocos e porcos com HP/Partículas) e renderização vetorial completa via Canvas (Pássaro, Porcos, Cenário), sem imagens externas.. Ao criar o claude e possiveis skills, defina que deve-se criar o código HTML5/JS único de um clone de Angry Birds utilizando Matter.js. O jogo deve ter física de estilingue manual (arrastar/soltar responsivo e seguindo lógica física de ação reação ou seja, puxar o estilingue deve haver a reação do passaro voar na direcao oposta), sistema de destruição estrutural realista (blocos e porcos com HP/Partículas) e renderização vetorial completa via Canvas (Pássaro, Porcos, Cenário), sem imagens externas. Use principios focados em DevOps, desenvolvimento de jogos em diversos frameworks comohtml, css e javascript,  com engines e bibliotecas que façam com que os jogos tenham alta qualidade, baixa complexidade sempre que possivel e alto desempenho. Mais importante o jogo deve ser fisicamente funcional, significando que a física de puxar o estilingue e o passarinho sofrer a ação da elasticidade (ação/reação) e a direção do estilingue devem fisicar fazer sentido e funcionar. Para andar mais rápido, vejo o que dá para paralelizar e delegue subagents rodando em paralelo pra dar mais agilidade a criacao.

    ```
4. Gere planejamento com `/speckit.plan`.
5. Ajuste com `/speckit.clarify` quando necessário.
6. Gere tarefas com `/speckit.tasks`.

## Gate de qualidade obrigatório (antes do /speckit.implement)

- Revisão da spec.
- Revisão do plano.
- Aprovação explícita dos dois artefatos antes de implementar.

Somente após esse gate, execute:

```text
/speckit.implement
```

## Iteração obrigatória após implementar

1. Teste o `index.html` gerado no navegador jogando de verdade.
2. Quando houver falhas (estilingue, colisão, física, travamento, UX), descreva em linguagem natural o problema para a IA.
3. Volte ao fluxo SDD para refinamento com `/speckit.plan` ou `/speckit.check` e aplique ajustes.
4. Reimplemente e reteste o `index.html`.
5. Repita até obter jogo jogável e estável.

## Validação guiada

- Constituição criada e revisada.
- Especificação gerada para o jogo.
- Plano e tarefas geradas.
- Gate de qualidade realizado antes da implementação (revisão de spec e plano por pares).
- O lab utilizou apenas o prompt único de Angry Birds.
- O `index.html` foi testado e iterado com feedback em linguagem natural.
- Implementação concluída com artefatos SDD versionáveis.

## Referências

- Spec-Driven Development (Spec Kit): https://developer.microsoft.com/blog/spec-driven-development-spec-kit
- VS Code + GitHub Copilot: https://code.visualstudio.com/docs/copilot/overview
- Matter.js: https://brm.io/matter-js/
