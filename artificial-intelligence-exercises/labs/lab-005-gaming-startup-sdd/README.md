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
specify init my-project --ai copilot
```

3. Entre no projeto no VS Code.
4. Defina a constituição de engenharia no chat.
5. Especifique o produto (jogo), gere plano, refine e implemente.

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

## Execução com SDD

1. Defina a constituição do projeto:

```text
/speckit.constitution crie princípios focados em DevOps, desenvolvimento de jogos em diversos frameworks como python pygame ou html, css e javascript, com engines e bibliotecas que façam com que os jogos tenham alta qualidade, baixa complexidade sempre que possível e alto desempenho.
```

2. Para cada prompt acima, execute `/speckit.specify` usando exatamente o mesmo texto do prompt.
3. Gere planejamento com `/speckit.plan`.
4. Ajuste com `/speckit.clarify` quando necessário.
5. Gere tarefas com `/speckit.tasks`.

## Gate de qualidade obrigatório (antes do /speckit.implement)

- Revisão da spec por pares (ou dupla).
- Revisão do plano por pares (ou dupla).
- Aprovação explícita dos dois artefatos antes de implementar.

Somente após esse gate, execute:

```text
/speckit.implement
```

## Validação guiada

- Constituição criada e revisada.
- Especificação gerada para o jogo.
- Plano e tarefas geradas.
- Gate de qualidade realizado antes da implementação (revisão de spec e plano por pares).
- Implementação concluída com artefatos SDD versionáveis.
