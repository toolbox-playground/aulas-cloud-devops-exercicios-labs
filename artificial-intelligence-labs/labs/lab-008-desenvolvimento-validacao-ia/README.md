# Lab 008 - Do pedido em linguagem natural à aplicação local e ao PR

## Objetivo

Praticar o ciclo de desenvolvimento com um agente de IA (**Claude Code** ou **Codex**): descrever → ver uma proposta de layout → escolher → o agente implementa → roda localmente → você testa no navegador → pede ajustes → testes → PR.

O ponto de partida é um painel de serviços com dados fictícios, sem filtro e sem tratar status ausente (aparece `undefined`). É um MVP didático, sem login, pagamento ou dados pessoais.

## Dificuldade e tempo

- Dificuldade: Intermediário
- Tempo estimado: 15 a 20 minutos

## Pré-requisitos

| Ferramenta | Como conferir |
|---|---|
| Node.js 20+ (testes com `node --test`) | `node -v` |
| Python 3 (servidor local) | `python3 --version` |
| Git | `git --version` |
| Claude Code **ou** Codex | `claude --version` ou `codex --version` |
| (Opcional, só para o PR) GitHub CLI autenticada | `gh auth status` |

## Passo a passo

### 0. Entrar na pasta do lab

Todos os comandos deste README usam a variável `LAB`, com o caminho completo da pasta do lab. Assim, cada bloco funciona de onde você estiver no terminal.

```bash
# Se ainda não tem o repositório, clone e entre nele
git clone https://github.com/toolbox-playground/aulas-cloud-devops-exercicios-labs.git
cd aulas-cloud-devops-exercicios-labs

# Na raiz do repositório (a pasta que contém artificial-intelligence-labs/)
export LAB="$PWD/artificial-intelligence-labs/labs/lab-008-desenvolvimento-validacao-ia"
cd "$LAB"
```

Se já clonou antes, entre na pasta `aulas-cloud-devops-exercicios-labs` e rode só as duas últimas linhas. Se abrir outro terminal, defina o `LAB` de novo do mesmo jeito.

### 1. Criar a cópia de trabalho

O script copia o `starter/` para `app/` e cria um commit de baseline (repositório git local, separado deste repositório).

```bash
cd "$LAB"
bash scripts/setup.sh
cd "$LAB/app"
npm run dev        # http://127.0.0.1:5173 · Ctrl+C para parar
```

Abra o navegador e veja o estado inicial (repare no `undefined` do serviço `frete`). Pare o servidor.

### 2. Pedir uma proposta de layout

Abra o agente na pasta `app/`, criada pelo setup:

```bash
cd "$LAB/app"
claude      # ou: codex
```

```text
Quero um painel simples de serviços para uma demonstração local, com os dados fictícios de
data/services.json. Antes de implementar a interface final, proponha um layout limpo, com filtro
por status e boa usabilidade no celular. Vou avaliar a proposta e pedir ajustes. Depois que eu
escolher a direção, implemente, execute localmente e me passe a URL para testar. Preserve os
dados e trate status desconhecido e resultado vazio. Registre um plano curto em docs/plans/.
```

Avalie a proposta e peça ajustes em linguagem natural. Só depois diga para implementar.

### 3. Testar de verdade e iterar

Abra a URL que o agente informar. Resultado esperado de cada filtro:

| Filtro | Serviços |
|---|---|
| Todos | 7 |
| online | pedidos-api, catalogo, estoque |
| degraded | pagamentos, notificacoes |
| offline | relatorios |
| desconhecido | frete |

Teste: filtro "Todos", cada status, o serviço sem status ("desconhecido"), um filtro sem resultados e a tela estreita (DevTools → modo celular). Peça ajustes concretos:

```text
A aplicação abriu, mas [descreva o que viu]. Eu esperava [exemplo concreto].
Ajuste e confira o resultado local; indique o que verificou e o que ainda preciso testar.
```

### 4. Testes

```text
Escreva testes para a lógica do filtro (todos, cada status, desconhecido e vazio) e rode npm test.
```

### 5. PR (somente com autorização e num repositório seu de laboratório)

Não abra PR neste repositório de exercícios. Use um repositório ou fork seu, por exemplo:

```bash
cd "$LAB/app"
gh repo create meu-painel-lab-008 --private --source . --push
```

```text
Crie uma branch, faça commit das mudanças e abra um pull request neste repositório, com uma
descrição do que mudou e de como testar. Depois mostre o estado dos checks.
```

Sem repositório remoto, peça só o diff e a descrição do PR prontos, e registre esse limite.

### 6. Recomeçar ou limpar

```bash
cd "$LAB"
bash scripts/reset.sh       # descarta app/ e cria de novo a partir do starter
bash scripts/teardown.sh    # remove app/ (pare o npm run dev antes, com Ctrl+C)
```

## Critério de conclusão

- A tela abre localmente; "Todos" mostra os 7 serviços; cada filtro mostra o subconjunto certo.
- O serviço sem status aparece como "desconhecido"; um filtro sem resultados mostra estado vazio explicativo.
- Os controles cabem e funcionam em tela estreita.
- `npm test` passa.
- Você validou o resultado no navegador. PR real só com autorização.
