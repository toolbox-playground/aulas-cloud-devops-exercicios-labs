# Lab 005 - Gaming Startup de Sucesso com SDD

## Objetivo

Construir um jogo com abordagem Specification-Driven Development (SDD), com governança, planejamento e implementação orientada por especificações.

## Dificuldade e tempo

- Dificuldade: Avançado
- Tempo estimado: 70 a 100 minutos

## Propósito

Mostrar como SDD reduz caos de vibe coding e aumenta previsibilidade, qualidade e manutenção do projeto.

## Pré-requisitos

- VS Code + Copilot
- Ambiente com Spec Kit/SDD
- Referência: https://developer.microsoft.com/blog/spec-driven-development-spec-kit

## Passo a passo

1. Estude rapidamente o framework SDD (Spec Kit).
2. Inicialize projeto:

```bash
specify init my-project-sdd --integration claude
```

3. Entre no projeto no VS Code.
4. Defina a constituição de engenharia no chat.
5. Especifique o produto (jogo), gere plano, refine e implemente.

## Prompt de comparação (igual ao Lab 002 - Prompt Médio)

Use somente este prompt para reduzir complexidade e comparar os primeiros resultados entre Lab 002, Lab 004 e Lab 005.

### Prompt único

```text
Crie um código HTML5/JS único de um clone de Angry Birds utilizando Matter.js. O jogo deve ter física de estilingue manual (arrastar/soltar responsivo), sistema de destruição estrutural realista (blocos e porcos com HP/Partículas) e renderização vetorial completa via Canvas (Pássaro, Porcos, Cenário), sem imagens externas.
```

## Execução com SDD

1. Defina a constituição do projeto:

```text
/speckit.constitution crie princípios focados em DevOps, desenvolvimento de jogos em diversos frameworks como python pygame ou html, css e javascript, com engines e bibliotecas que façam com que os jogos tenham alta qualidade, baixa complexidade sempre que possível e alto desempenho.
```

2. Execute `/speckit.specify` usando exatamente o texto do prompt único.
3. Gere planejamento com `/speckit.plan`.
4. Ajuste com `/speckit.clarify` quando necessário.
5. Gere tarefas com `/speckit.tasks`.

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
