# Prompts do lab 008

## Proposta de layout

```text
Quero um painel simples de serviços para uma demonstração local, com os dados fictícios de
data/services.json. Antes de implementar a interface final, proponha um layout limpo, com filtro
por status e boa usabilidade no celular. Vou avaliar a proposta e pedir ajustes. Depois que eu
escolher a direção, implemente, execute localmente e me passe a URL para testar. Preserve os
dados e trate status desconhecido e resultado vazio. Registre um plano curto em docs/plans/.
```

## Iteração

```text
A aplicação abriu, mas [descreva o que viu]. Eu esperava [exemplo concreto].
Ajuste e confira o resultado local; indique o que verificou e o que ainda preciso testar.
```

Exemplos: "mantenha o filtro visível no celular", "o estado vazio precisa explicar que não há serviços com esse status".

## Testes

```text
Escreva testes para a lógica do filtro (todos, cada status, desconhecido e vazio) e rode npm test.
```

## PR (repositório de laboratório seu, com autorização)

```text
Crie uma branch, faça commit das mudanças e abra um pull request neste repositório, com uma
descrição do que mudou e de como testar. Depois mostre o estado dos checks.
```
