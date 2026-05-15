# Lab 001 — GitHub Actions: Introdução

## Objetivo

Entender a estrutura de um workflow do GitHub Actions, fazer fork de um repositório Node.js
com pipeline pronta e observar o pipeline rodar automaticamente após um push.

## Duração e dificuldade

- Duração estimada: 20 a 30 minutos
- Dificuldade: iniciante

## Pré-requisitos

- Conta no GitHub
- Git instalado na máquina

## Repositório de referência

[toolbox-playground/pipelines-github-actions-exemplo-basico](https://github.com/toolbox-playground/pipelines-github-actions-exemplo-basico)

## Fluxo recomendado do aluno

### 1. Fazer fork do repositório

1. Acesse [github.com/toolbox-playground/pipelines-github-actions-exemplo-basico](https://github.com/toolbox-playground/pipelines-github-actions-exemplo-basico).
2. Clique em **Fork** (canto superior direito) e confirme em sua conta pessoal.
3. Clone o fork localmente:

```bash
git clone https://github.com/<seu-usuario>/pipelines-github-actions-exemplo-basico
cd pipelines-github-actions-exemplo-basico
```

### 2. Entender o workflow

Abra o arquivo `.github/workflows/main.yml` e leia cada bloco:

- **`name`**: nome exibido na aba Actions do GitHub.
- **`on.push`**: o que dispara o workflow (push no repositório).
- **`paths-ignore`**: arquivos que, se alterados sozinhos, não disparam o workflow.
- **`jobs.build`**: instala dependências com `npm install`.
- **`jobs.test`**: executa testes com `npm test`.
- **`runs-on: ubuntu-latest`**: os jobs rodam em uma VM Linux gerenciada pelo GitHub.

### 3. Disparar o pipeline com um push

Faça uma alteração pequena e faça push:

```bash
echo "## Meu fork" >> README.md
git add README.md
git commit -m "test: dispara pipeline"
git push
```

### 4. Acompanhar a execução

1. No repositório no GitHub, clique na aba **Actions**.
2. Clique no workflow que acabou de ser disparado.
3. Clique em cada job (**build** e **test**) para ver os logs em tempo real.
4. Observe que os dois jobs rodam **em paralelo** — sem `needs`, não há dependência entre eles.

### 5. Explorar (opcional)

- Edite o `main.yml` para adicionar `needs: build` no job `test` e veja os jobs rodando em sequência.
- Adicione um passo `echo "Deploy realizado!"` ao final do job `test`.
- Altere `on: push` para `on: [push, pull_request]` e abra um PR para ver o pipeline rodar.

## Como demonstrar em aula (roteiro curto)

1. **[5 min]** Mostrar a estrutura do `.github/workflows/main.yml` linha a linha.
2. **[5 min]** Fazer um push ao vivo e abrir a aba Actions para acompanhar.
3. **[5 min]** Explorar os logs de cada job e mostrar o conceito de paralelismo.
4. **[5 min]** Editar o workflow para adicionar `needs` e mostrar execução sequencial.

## Referências

- [GitHub Actions — Quickstart](https://docs.github.com/en/actions/quickstart)
- [Workflow syntax for GitHub Actions](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)
- [Repositório de referência](https://github.com/toolbox-playground/pipelines-github-actions-exemplo-basico)
