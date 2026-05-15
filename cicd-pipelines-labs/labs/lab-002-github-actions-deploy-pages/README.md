# Lab 002 — GitHub Actions: Build, Test e Deploy no GitHub Pages

## Objetivo

Criar um pipeline GitHub Actions completo com as etapas de instalar dependências, build,
testes automatizados e deploy de site estático no GitHub Pages — sem nenhum serviço externo.

## Duração e dificuldade

- Duração estimada: 30 a 40 minutos
- Dificuldade: iniciante

## Pré-requisitos

- Conta no GitHub
- Git instalado na máquina
- Node.js 20+ instalado (para testar localmente)

## Repositório de referência

[toolbox-playground/youtube-serie-cicd](https://github.com/toolbox-playground/youtube-serie-cicd)
(pasta `github-actions-pipeline-completa/`)

## Fluxo recomendado do aluno

### 1. Fazer fork do repositório

1. Acesse [github.com/toolbox-playground/youtube-serie-cicd](https://github.com/toolbox-playground/youtube-serie-cicd).
2. Clique em **Fork** e confirme em sua conta.
3. Clone localmente:

```bash
git clone https://github.com/<seu-usuario>/youtube-serie-cicd
cd youtube-serie-cicd
```

### 2. Rodar a aplicação localmente

```bash
cd github-actions-pipeline-completa
npm ci
npm run build
npm test
```

Resultado esperado: a pasta `dist/` é criada com `index.html` e os testes passam.

Para visualizar no navegador:

```bash
npx serve dist
```

Abra `http://localhost:3000`.

### 3. Habilitar o GitHub Pages no seu fork

1. No repositório do fork no GitHub, vá em **Settings > Pages**.
2. Em **Build and deployment > Source**, selecione **GitHub Actions**.
3. Salve.

### 4. Entender o workflow

Abra `.github/workflows/deploy.yml` e identifique as 7 etapas:

| Etapa | Ação | O que faz |
|-------|------|-----------|
| 1 | **Checkout** | Clona o repositório na VM |
| 2 | **Setup Node.js** | Instala Node 20 com cache do npm |
| 3 | **Install dependencies** | `npm ci` (instalação exata do lockfile) |
| 4 | **Build** | `npm run build` — gera a pasta `dist/` |
| 5 | **Test** | `npm test` — verifica o artefato gerado |
| 6 | **Upload artifact** | Envia `dist/` para o GitHub Pages |
| 7 | **Deploy** | Publica o artefato como site público |

### 5. Disparar o pipeline

Faça um push para a branch `main`:

```bash
echo "<!-- $(date) -->" >> github-actions-pipeline-completa/src/index.html
git add .
git commit -m "test: dispara pipeline de deploy"
git push
```

1. Vá em **Actions** e acompanhe o workflow `Deploy to GitHub Pages`.
2. Quando finalizar, o site estará publicado em:
   `https://<seu-usuario>.github.io/youtube-serie-cicd/`

### 6. Explorar (opcional)

- Acrescente um passo de `echo` para exibir a versão do Node instalada.
- Adicione `on: pull_request` ao trigger e abra um PR para ver o pipeline rodar sem o deploy.
- Edite `github-actions-pipeline-completa/src/index.html` e veja a mudança publicada após o push.

## Como demonstrar em aula (roteiro curto)

1. **[5 min]** Mostrar a aplicação rodando localmente com `npm test`.
2. **[5 min]** Explicar o `deploy.yml` etapa por etapa, destacando `actions/upload-pages-artifact` e `actions/deploy-pages`.
3. **[10 min]** Fazer push ao vivo e acompanhar o deploy até o site ficar online.
4. **[5 min]** Abrir o site publicado no navegador e mostrar a URL do GitHub Pages.

## Referências

- [Repositório de referência](https://github.com/toolbox-playground/youtube-serie-cicd)
- [GitHub Pages — Publishing source](https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site)
- [actions/deploy-pages](https://github.com/actions/deploy-pages)
