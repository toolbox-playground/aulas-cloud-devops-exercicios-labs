# Lab 008 · guia do instrutor

## Estado inicial (ensaio de 13/11/2026)

- `setup.sh` cria `app/` com commit de baseline; `npm test` passa (1 teste: `formatHora`).
- `npm run dev` serve em http://127.0.0.1:5173; a lista mostra 7 serviços e `frete` aparece com `undefined` (sem status).

## Dados e respostas esperadas do filtro

| Filtro | Serviços |
|---|---|
| Todos | 7 |
| online | pedidos-api, catalogo, estoque (3) |
| degraded | pagamentos, notificacoes (2) |
| offline | relatorios (1) |
| desconhecido | frete (1) |

Para testar o estado vazio, peça um status sem registros (por exemplo, depois de filtrar por um time) ou combine que "offline" fique vazio removendo `relatorios` numa cópia.

## O que observar

- O agente propõe antes de implementar e respeita a escolha feita.
- Informa comando, URL e como parar o servidor.
- Testes cobrem a lógica do filtro, não só a renderização.
- Você valida pelo navegador; não é necessário ler cada linha desse MVP. Se houver publicação, credenciais ou dados reais, a revisão precisa ser outra.

## Sequência de gravação

1. `setup.sh` e mostrar o estado inicial no navegador.
2. Pedido de layout → proposta → ajuste → "pode implementar".
3. Testar no navegador (inclusive modo celular) → um pedido de ajuste concreto.
4. Testes.
5. PR num repositório de laboratório seu, se autorizado; senão, diff e descrição prontos.
