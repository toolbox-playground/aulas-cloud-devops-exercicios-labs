# CI/CD Pipelines Labs — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Criar a trilha `cicd-pipelines-labs` no repositório `aulas-cloud-devops-exercicios-labs` com 6 labs progressivos de pipelines CI/CD, baseados nos repositórios existentes da org toolbox-playground.

**Architecture:** Nova pasta `cicd-pipelines-labs/` seguindo o mesmo padrão das trilhas existentes (README índice + uma pasta por lab com README.md). Os labs são guias estruturados que referenciam repos externos da org para fork — o aluno faz fork, configura credenciais e dispara pipelines reais.

**Tech Stack:** GitHub Actions, Jenkins + Docker, Harness CI/CD, Checkov, Gitleaks, Snyk, TruffleHog, Trivy, Docker Hub, GCP Cloud Run, SonarCloud, GitHub Pages

**Repos de origem usados (toolbox-playground):**
- `pipelines-github-actions-exemplo-basico` → Lab 001
- `youtube-serie-cicd` (pasta `github-actions-pipeline-completa`) → Lab 002
- `pipelines-jenkins-exemplo-basico` → Lab 003
- `pipelines-harness-exemplo-basico` → Lab 004
- `pipelines-seguranca-exemplo-basico` → Lab 005
- `pipelines-exemplo-basico-desafio` → Lab 006

**Repos ignorados (README vazio ou meta-collection):**
- `pipeline-travisci-exemplo-basico` — README vazio
- `pipeline-circleci-exemplo-basico` — README vazio
- `pipelines-exemplo-basico` — meta-collection genérica, coberta pelos outros labs

---

## Estrutura de arquivos a criar/modificar

```
cicd-pipelines-labs/
├── README.md                                         ← CRIAR (índice da trilha)
└── labs/
    ├── lab-001-github-actions-basico/
    │   └── README.md                                 ← CRIAR
    ├── lab-002-github-actions-deploy-pages/
    │   └── README.md                                 ← CRIAR
    ├── lab-003-jenkins-docker/
    │   └── README.md                                 ← CRIAR
    ├── lab-004-harness-cicd/
    │   └── README.md                                 ← CRIAR
    ├── lab-005-seguranca-pipelines/
    │   └── README.md                                 ← CRIAR
    └── lab-006-pipeline-completo-desafio/
        └── README.md                                 ← CRIAR

README.md (raiz do repo)                              ← MODIFICAR (adicionar link)
```

---

## Task 1: Estrutura da trilha + README índice + link no root README

**Files:**
- Create: `cicd-pipelines-labs/README.md`
- Modify: `README.md`

- [ ] **Step 1: Criar o README índice da trilha**

Criar `cicd-pipelines-labs/README.md` com este conteúdo exato:

```markdown
# CI/CD Pipelines Labs

Trilha de exercícios práticos de pipelines de integração e entrega contínua (CI/CD).

## Labs

| # | Lab | Ferramenta | Nível |
|---|-----|-----------|-------|
| 001 | [GitHub Actions — Introdução](labs/lab-001-github-actions-basico/README.md) | GitHub Actions | Iniciante |
| 002 | [GitHub Actions — Build, Test e Deploy no GitHub Pages](labs/lab-002-github-actions-deploy-pages/README.md) | GitHub Actions + GitHub Pages | Iniciante |
| 003 | [Jenkins com Docker](labs/lab-003-jenkins-docker/README.md) | Jenkins + Docker + Docker Hub | Intermediário |
| 004 | [Harness CI/CD](labs/lab-004-harness-cicd/README.md) | Harness + Docker Hub | Intermediário |
| 005 | [Segurança em Pipelines](labs/lab-005-seguranca-pipelines/README.md) | Checkov, Gitleaks, Snyk, TruffleHog, Trivy | Intermediário |
| 006 | [Pipeline Completo — Desafio](labs/lab-006-pipeline-completo-desafio/README.md) | GitHub Actions + Docker Hub + GCP + SonarCloud + Snyk | Avançado |

## Progressão sugerida

1. **Iniciante**: Labs 001 e 002 — aprenda GitHub Actions do zero ao deploy real
2. **Intermediário**: Labs 003 e 004 — experimente plataformas de CI/CD (self-hosted e cloud)
3. **Segurança**: Lab 005 — adicione scans de segurança ao seu pipeline
4. **Avançado**: Lab 006 — pipeline completo com múltiplos serviços integrados
```

- [ ] **Step 2: Adicionar link no root README.md**

No arquivo `README.md` (raiz do repo), adicionar dentro do bloco `## Trilhas`:

```markdown
- [CI/CD Pipelines Labs](cicd-pipelines-labs/README.md)
```

- [ ] **Step 3: Commit**

```bash
git add cicd-pipelines-labs/README.md README.md
git commit -m "feat: cria trilha cicd-pipelines-labs com índice e link no README raiz"
git push
```

---

## Task 2: Lab 001 — GitHub Actions Básico

**Files:**
- Create: `cicd-pipelines-labs/labs/lab-001-github-actions-basico/README.md`

**Fonte:** https://github.com/toolbox-playground/pipelines-github-actions-exemplo-basico

- [ ] **Step 1: Criar o README do lab**

Criar `cicd-pipelines-labs/labs/lab-001-github-actions-basico/README.md` com este conteúdo:

```markdown
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

Faça uma alteração pequena (ex.: acrescente uma linha no README) e faça push:

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
```

- [ ] **Step 2: Commit**

```bash
git add cicd-pipelines-labs/labs/lab-001-github-actions-basico/README.md
git commit -m "feat: adiciona lab-001 GitHub Actions introducao"
git push
```

---

## Task 3: Lab 002 — GitHub Actions com Deploy no GitHub Pages

**Files:**
- Create: `cicd-pipelines-labs/labs/lab-002-github-actions-deploy-pages/README.md`

**Fonte:** https://github.com/toolbox-playground/youtube-serie-cicd (pasta `github-actions-pipeline-completa`)

- [ ] **Step 1: Criar o README do lab**

Criar `cicd-pipelines-labs/labs/lab-002-github-actions-deploy-pages/README.md` com este conteúdo:

```markdown
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

- Abra o editor de um job e acrescente um passo de `echo` para exibir a versão do Node.
- Adicione `on: pull_request` ao trigger e abra um PR para ver o pipeline rodar sem o deploy.
- Leia o arquivo `github-actions-pipeline-completa/src/index.html` e altere o conteúdo.

## Como demonstrar em aula (roteiro curto)

1. **[5 min]** Mostrar a aplicação rodando localmente com `npm test`.
2. **[5 min]** Explicar o `deploy.yml` etapa por etapa, destacando `actions/upload-pages-artifact` e `actions/deploy-pages`.
3. **[10 min]** Fazer push ao vivo e acompanhar o deploy até o site ficar online.
4. **[5 min]** Abrir o site publicado no navegador e mostrar a URL do GitHub Pages.

## Referências

- [Repositório de referência](https://github.com/toolbox-playground/youtube-serie-cicd)
- [GitHub Actions — Deploy to GitHub Pages](https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site)
- [actions/deploy-pages](https://github.com/actions/deploy-pages)
```

- [ ] **Step 2: Commit**

```bash
git add cicd-pipelines-labs/labs/lab-002-github-actions-deploy-pages/README.md
git commit -m "feat: adiciona lab-002 GitHub Actions deploy GitHub Pages"
git push
```

---

## Task 4: Lab 003 — Jenkins com Docker

**Files:**
- Create: `cicd-pipelines-labs/labs/lab-003-jenkins-docker/README.md`

**Fonte:** https://github.com/toolbox-playground/pipelines-jenkins-exemplo-basico

- [ ] **Step 1: Criar o README do lab**

Criar `cicd-pipelines-labs/labs/lab-003-jenkins-docker/README.md` com este conteúdo:

```markdown
# Lab 003 — Jenkins com Docker

## Objetivo

Subir um servidor Jenkins via Docker, configurar credenciais de GitHub e Docker Hub,
e criar uma Multibranch Pipeline que builda e faz push de uma imagem Docker automaticamente
a cada push no repositório.

## Duração e dificuldade

- Duração estimada: 45 a 60 minutos
- Dificuldade: intermediário

## Pré-requisitos

- Docker instalado
- Conta no GitHub
- Conta no Docker Hub ([hub.docker.com/signup](https://hub.docker.com/signup)) — crie um repositório chamado `pipelines-jenkins-exemplo-basico`

## Repositório de referência

[toolbox-playground/pipelines-jenkins-exemplo-basico](https://github.com/toolbox-playground/pipelines-jenkins-exemplo-basico)

## Fluxo recomendado do aluno

### 1. Fazer fork e configurar o Jenkinsfile

1. Acesse [github.com/toolbox-playground/pipelines-jenkins-exemplo-basico](https://github.com/toolbox-playground/pipelines-jenkins-exemplo-basico) e clique em **Fork**.
2. Clone o fork localmente:

```bash
git clone https://github.com/<seu-usuario>/pipelines-jenkins-exemplo-basico
cd pipelines-jenkins-exemplo-basico
```

3. Edite `dotnet/Jenkinsfile` e altere as duas variáveis:

```groovy
DOCKER_NAMESPACE = '<seu-namespace-no-dockerhub>'
DOCKER_REPOSITORY = 'pipelines-jenkins-exemplo-basico'
```

4. Salve, faça commit e push:

```bash
git add dotnet/Jenkinsfile
git commit -m "config: atualiza namespace e repositório Docker Hub"
git push
```

### 2. Subir o Jenkins via Docker

Dentro do diretório clonado, construa a imagem customizada do Jenkins:

```bash
docker build -t jenkins:local -f DockerfileJenkins .
```

Execute o container (Linux/macOS):

```bash
docker run --name jenkins --rm \
  -p 8080:8080 -p 50000:50000 \
  --volume jenkins-data:/var/jenkins_home \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --env JENKINS_ADMIN_ID=admin \
  --env JENKINS_ADMIN_PASSWORD=password \
  jenkins:local
```

> **Windows:** substitua `/var/run/docker.sock` por `//var/run/docker.sock`.

Aguarde as mensagens de inicialização e acesse [http://localhost:8080](http://localhost:8080).

Login: `admin` / `password`

### 3. Configurar credenciais

1. Clique em **Gerenciar Jenkins > Credentials > System > Global credentials > Add Credentials**.

2. **Credencial do GitHub** (para acessar o repositório):
   - Kind: `Username with password`
   - Username: seu usuário GitHub
   - Password: token gerado em [github.com/settings/tokens/new?scopes=repo,user](https://github.com/settings/tokens/new?scopes=repo,user)
   - ID: `toolboxgithub`

3. **Credencial do Docker Hub** (para fazer push da imagem):
   - Kind: `Username with password`
   - Username: seu usuário Docker Hub
   - Password: token gerado em [hub.docker.com/settings/security](https://hub.docker.com/settings/security) > **New Access Token**
   - ID: `toolboxdocker`

### 4. Criar a Multibranch Pipeline

1. No Painel de Controle, clique em **Nova Tarefa**.
2. Nome: `Pipeline Jenkins` — tipo: **Multibranch Pipeline**. Clique em **Tudo certo**.
3. Em **Branch Sources > Add source > GitHub**:
   - Credentials: `toolboxgithub`
   - Repository HTTPS URL: `https://github.com/<seu-usuario>/pipelines-jenkins-exemplo-basico`
4. Em **Build Configuration**:
   - Mode: `by Jenkinsfile`
   - Script Path: `dotnet/Jenkinsfile`
5. Clique em **Save**.

O Jenkins vai escanear o repositório e disparar o pipeline automaticamente.

### 5. Acompanhar o pipeline

1. Aguarde o scan terminar e clique em **Pipeline Jenkins > main**.
2. Clique em **Histórico de Compilações** para ver o build em andamento.
3. Quando finalizar, verifique no Docker Hub que a imagem foi publicada.

### 6. Desafio (opcional)

Na pasta `nodejs/` do repositório há uma aplicação Node.js com seu próprio `Dockerfile` e `Jenkinsfile`. Tente criar um segundo job no Jenkins apontando o Script Path para `nodejs/Jenkinsfile`.

## Como demonstrar em aula (roteiro curto)

1. **[5 min]** Mostrar o `DockerfileJenkins` e explicar por que montamos o socket do Docker.
2. **[5 min]** Subir o container e abrir o Jenkins no browser.
3. **[10 min]** Configurar as credenciais e criar o job Multibranch Pipeline ao vivo.
4. **[10 min]** Acompanhar o pipeline rodar e mostrar a imagem no Docker Hub.
5. **[5 min]** Abrir o `Jenkinsfile` e explicar as etapas: checkout, build, push.

## Limpeza

```bash
docker stop jenkins
docker volume rm jenkins-data
```

## Referências

- [Repositório de referência](https://github.com/toolbox-playground/pipelines-jenkins-exemplo-basico)
- [Jenkins Docker Hub — jenkins/jenkins:lts-jdk17](https://hub.docker.com/r/jenkins/jenkins/)
- [Jenkins Multibranch Pipeline](https://www.jenkins.io/doc/book/pipeline/multibranch/)
```

- [ ] **Step 2: Commit**

```bash
git add cicd-pipelines-labs/labs/lab-003-jenkins-docker/README.md
git commit -m "feat: adiciona lab-003 Jenkins com Docker"
git push
```

---

## Task 5: Lab 004 — Harness CI/CD

**Files:**
- Create: `cicd-pipelines-labs/labs/lab-004-harness-cicd/README.md`

**Fonte:** https://github.com/toolbox-playground/pipelines-harness-exemplo-basico

- [ ] **Step 1: Criar o README do lab**

Criar `cicd-pipelines-labs/labs/lab-004-harness-cicd/README.md` com este conteúdo:

```markdown
# Lab 004 — Harness CI/CD

## Objetivo

Criar uma conta gratuita no Harness, configurar conectores de GitHub e Docker Hub,
importar uma pipeline pronta do repositório e disparar execuções via push e pull request.

## Duração e dificuldade

- Duração estimada: 45 a 60 minutos
- Dificuldade: intermediário

## Pré-requisitos

- Conta no GitHub
- Conta no Docker Hub ([hub.docker.com/signup](https://hub.docker.com/signup)) — crie um repositório chamado `pipelines-harness-exemplo-basico`
- Conta gratuita no Harness ([app.harness.io/auth/#/signup](https://app.harness.io/auth/#/signup)) — plano free: 100 builds/mês

## Repositório de referência

[toolbox-playground/pipelines-harness-exemplo-basico](https://github.com/toolbox-playground/pipelines-harness-exemplo-basico)

> **Atenção:** o nome do fork **deve** ser `pipelines-harness-exemplo-basico-fork` — o arquivo
> de pipeline dentro do repositório referencia esse nome exato.

## Fluxo recomendado do aluno

### 1. Fazer fork com o nome correto

1. Acesse [github.com/toolbox-playground/pipelines-harness-exemplo-basico](https://github.com/toolbox-playground/pipelines-harness-exemplo-basico) e clique em **Fork**.
2. No campo de nome do fork, adicione `-fork` ao final: `pipelines-harness-exemplo-basico-fork`.
3. Clone localmente e edite o arquivo `.harness/pipelines/toolboxplaygroundharness.yaml`:
   - Localize `repo: toolboxplayground/pipelines-harness-exemplo-basico`
   - Substitua `toolboxplayground` pelo seu namespace no Docker Hub (geralmente seu usuário).
4. Faça commit e push:

```bash
git add .harness/pipelines/toolboxplaygroundharness.yaml
git commit -m "config: atualiza namespace do Docker Hub"
git push
```

### 2. Criar tokens necessários

**GitHub Personal Access Token** (necessário para o conector do Harness):

Acesse [github.com/settings/tokens/new?scopes=repo,user,admin:org_hook,admin:repo_hook](https://github.com/settings/tokens/new?scopes=repo,user,admin:org_hook,admin:repo_hook), em **Note** coloque `Harness` e clique em **Generate token**. Copie o token.

**Docker Hub Access Token**:

Acesse [hub.docker.com/settings/security](https://hub.docker.com/settings/security) > **New Access Token**. Description: `Harness Token`. Copie o token.

### 3. Configurar o Harness

**Habilitar Bi-Directional Sync:**

1. No Harness, clique na caixa de seleção no canto superior esquerdo > **Accounts** > sua conta.
2. Vá em **Account Settings > Default Settings > Git Experience**.
3. Marque **Enable Bi-Directional Sync**. Salve.

**Criar conector GitHub:**

1. Vá em **Projects > Default Project > Project Settings > Connectors > New Connector**.
2. Busque `GitHub` e selecione.
3. Name: `Toolbox_GitHub`
4. GitHub Account URL: `https://github.com/<seu-usuario>`
5. Test Repository: `pipelines-harness-exemplo-basico`
6. Authentication: Username = seu usuário GitHub. Password = clique em **Create or Select a Secret > New Secret Text**, Name: `GitHub PAT`, Value: cole o token. Salve.
7. Marque **Enable API access** e selecione o mesmo secret `GitHub PAT`.
8. Connect through: **Harness Platform**. Salve e aguarde **Verification successful**.

**Criar conector Docker Hub:**

1. Novo conector > busque `Docker Registry`.
2. Name: `Docker_Toolbox`
3. Provider Type: `DockerHub`
4. Docker Registry URL: `https://index.docker.io/v2/`
5. Username: seu usuário Docker Hub. Password: clique em **Create or Select a Secret > New Secret Text**, Name: `Docker Token`, Value: cole o token. Salve.
6. Connect through: **Harness Platform**. Salve e aguarde **Verification successful**.

### 4. Importar a pipeline

1. Vá em **Pipelines > seta ao lado de "+ Create a Pipeline" > Import from Git**.
2. Git provider: **Third-party Git provider**.
3. Git Connector: `Toolbox_GitHub`.
4. Repository: `pipelines-harness-exemplo-basico-fork`.
5. Git Branch: `main`.
6. YAML Path: `.harness/pipelines/toolboxplaygroundharness.yaml`.
7. Clique em **Import**.

### 5. Configurar a infraestrutura (Harness Cloud)

1. Abra a pipeline importada.
2. Clique em **NodeJS > Infrastructure > Update Card**.
3. Adicione um cartão de crédito (não haverá cobrança no plano free — 100 builds/mês).
4. Selecione **Cloud** e clique em **Continue**.

> Se preferir não cadastrar cartão, use a opção **Local** seguindo:
> [developer.harness.io/docs/continuous-integration/use-ci/set-up-build-infrastructure/define-a-docker-build-infrastructure](https://developer.harness.io/docs/continuous-integration/use-ci/set-up-build-infrastructure/define-a-docker-build-infrastructure/)

### 6. Importar Input Sets e Triggers

**Input Set para Pull Request:**
- **Input Sets > New Input Set > seta > Import From Git**
- Name: `pipelines-harness-exemplo-basico-pr-trigger-input-set`
- YAML Path: `.harness/pipelines-harness-exemplo-basico-pr-trigger-input-set.yaml`
- Clique em **Import**.

**Input Set para Push:**
- **New Input Set > Import From Git**
- Name: `pipelines-harness-exemplo-basico-push-trigger-input-set`
- YAML Path: `.harness/pipelines-harness-exemplo-basico-push-trigger-input-set.yaml`
- Clique em **Import**.

**Trigger para Push:**
- **Triggers > New Trigger > GitHub (Webhook)**
- Name: `Push Trigger` | Connector: `Toolbox_GitHub` | Repository: `pipelines-harness-exemplo-basico-fork` | Event: **Push**
- Pipeline Input: selecione o input set de push. Clique em **Create Trigger**.

**Trigger para Pull Request:**
- **New Trigger > GitHub (Webhook)**
- Name: `PR Trigger` | Connector: `Toolbox_GitHub` | Repository: `pipelines-harness-exemplo-basico-fork` | Event: **Pull Request**
- Pipeline Input: selecione o input set de PR. Clique em **Create Trigger**.

### 7. Testar a pipeline

Faça uma alteração no README do fork e faça push:

```bash
echo "## Testado por <seu-nome>" >> README.md
git add README.md
git commit -m "test: dispara pipeline Harness"
git push
```

Volte ao Harness > **Pipelines** e observe a execução em andamento.

## Como demonstrar em aula (roteiro curto)

1. **[5 min]** Mostrar a interface do Harness e explicar o conceito de connectors.
2. **[10 min]** Criar os conectores de GitHub e Docker Hub ao vivo.
3. **[10 min]** Importar a pipeline e configurar a infraestrutura Cloud.
4. **[10 min]** Criar os triggers e disparar a pipeline com um push.
5. **[5 min]** Mostrar o resultado no Docker Hub e os logs da execução.

## Referências

- [Repositório de referência](https://github.com/toolbox-playground/pipelines-harness-exemplo-basico)
- [Harness CI — Free tier](https://www.harness.io/pricing)
- [Harness — Configure Docker build infrastructure](https://developer.harness.io/docs/continuous-integration/use-ci/set-up-build-infrastructure/define-a-docker-build-infrastructure/)
```

- [ ] **Step 2: Commit**

```bash
git add cicd-pipelines-labs/labs/lab-004-harness-cicd/README.md
git commit -m "feat: adiciona lab-004 Harness CI/CD"
git push
```

---

## Task 6: Lab 005 — Segurança em Pipelines

**Files:**
- Create: `cicd-pipelines-labs/labs/lab-005-seguranca-pipelines/README.md`

**Fonte:** https://github.com/toolbox-playground/pipelines-seguranca-exemplo-basico

- [ ] **Step 1: Criar o README do lab**

Criar `cicd-pipelines-labs/labs/lab-005-seguranca-pipelines/README.md` com este conteúdo:

```markdown
# Lab 005 — Segurança em Pipelines

## Objetivo

Explorar 5 ferramentas de segurança integradas em pipelines CI/CD: Checkov (IaC),
Gitleaks e TruffleHog (detecção de segredos), Snyk (vulnerabilidades em dependências)
e Trivy (vulnerabilidades em imagens de container).

## Duração e dificuldade

- Duração estimada: 45 a 60 minutos
- Dificuldade: intermediário

## Pré-requisitos

- Docker instalado (para rodar Checkov, TruffleHog e Trivy via container)
- Node.js instalado (para Snyk)
- Git instalado

## Repositório de referência

[toolbox-playground/pipelines-seguranca-exemplo-basico](https://github.com/toolbox-playground/pipelines-seguranca-exemplo-basico)

## Fluxo recomendado do aluno

### 1. Clonar o repositório

```bash
git clone https://github.com/toolbox-playground/pipelines-seguranca-exemplo-basico
cd pipelines-seguranca-exemplo-basico
```

### 2. Checkov — varredura de IaC (Infrastructure as Code)

O Checkov analisa arquivos Terraform, CloudFormation, Kubernetes e outros para identificar
configurações inseguras **antes** do deploy.

```bash
cd checkov
```

Siga as instruções do [README do Checkov](https://github.com/toolbox-playground/pipelines-seguranca-exemplo-basico/tree/main/checkov) dentro do repositório.

Comando rápido via Docker:

```bash
docker run --rm -v $(pwd):/tf bridgecrew/checkov -d /tf
```

**O que observar:** Checkov imprime PASSED/FAILED por recurso, com o ID da regra (ex: `CKV_AWS_23`) e o arquivo/linha que falhou.

### 3. Gitleaks — detecção de segredos no histórico Git

O Gitleaks escaneia commits em busca de senhas, tokens e chaves de API acidentalmente commitados.

```bash
cd ../gitleaks
```

Siga as instruções do [README do Gitleaks](https://github.com/toolbox-playground/pipelines-seguranca-exemplo-basico/tree/main/gitleaks) dentro do repositório.

Comando rápido via Docker:

```bash
docker run --rm -v $(pwd):/repo zricethezav/gitleaks detect --source /repo -v
```

**O que observar:** Gitleaks lista cada "finding" com o arquivo, linha, tipo de segredo e o commit onde apareceu.

### 4. Snyk — vulnerabilidades em dependências

O Snyk verifica se as bibliotecas usadas no projeto possuem CVEs conhecidos.

```bash
cd ../snyk
```

Siga as instruções do [README do Snyk](https://github.com/toolbox-playground/pipelines-seguranca-exemplo-basico/tree/main/snyk) dentro do repositório.

Para testar sem instalar o CLI:

```bash
# Instalar Snyk globalmente
npm install -g snyk

# Autenticar (abre o browser)
snyk auth

# Escanear as dependências do projeto
snyk test
```

**O que observar:** Snyk lista vulnerabilidades por severidade (Critical/High/Medium/Low), a versão afetada e a versão corrigida.

### 5. TruffleHog — detecção de segredos por entropia

O TruffleHog usa análise de entropia e regex para encontrar segredos em repositórios,
mesmo em branches antigas ou arquivos deletados.

```bash
cd ../trufflehog
```

Siga as instruções do [README do TruffleHog](https://github.com/toolbox-playground/pipelines-seguranca-exemplo-basico/tree/main/trufflehog) dentro do repositório.

Comando rápido via Docker:

```bash
docker run --rm trufflesecurity/trufflehog:latest github \
  --repo https://github.com/toolbox-playground/pipelines-seguranca-exemplo-basico
```

**O que observar:** TruffleHog mostra cada segredo encontrado com o tipo (AWS Key, GitHub Token, etc.), o commit e a branch de origem.

### 6. Trivy — varredura de imagens de container

O Trivy verifica imagens Docker em busca de CVEs em pacotes do sistema operacional e dependências de linguagem.

```bash
cd ../trivy
```

Siga as instruções do [README do Trivy](https://github.com/toolbox-playground/pipelines-seguranca-exemplo-basico/tree/main/trivy) dentro do repositório.

Comando rápido via Docker:

```bash
docker run --rm aquasec/trivy image nginx:latest
```

**O que observar:** Trivy lista vulnerabilidades por pacote, severidade e a versão com correção disponível.

### 7. Comparativo das ferramentas

| Ferramenta | O que escaneia | Quando usar |
|---|---|---|
| Checkov | IaC (Terraform, K8s, etc.) | Antes de aplicar infraestrutura |
| Gitleaks | Histórico Git (segredos) | Em cada push / PR |
| Snyk | Dependências (npm, pip, maven) | Em cada build |
| TruffleHog | Histórico Git (segredos, entropia) | Auditoria de repositório |
| Trivy | Imagens Docker | Antes de publicar no registry |

## Como demonstrar em aula (roteiro curto)

1. **[5 min]** Explicar o modelo de segurança shift-left: detectar cedo, antes do deploy.
2. **[5 min]** Rodar o Gitleaks e mostrar um "vazamento" detectado.
3. **[5 min]** Rodar o Trivy em uma imagem pública e mostrar os CVEs.
4. **[5 min]** Rodar o Snyk num projeto Node.js e mostrar a listagem de vulnerabilidades.
5. **[5 min]** Mostrar como cada ferramenta pode ser adicionada como step no GitHub Actions.

## Referências

- [Repositório de referência](https://github.com/toolbox-playground/pipelines-seguranca-exemplo-basico)
- [Checkov docs](https://www.checkov.io/1.Welcome/What%20is%20Checkov.html)
- [Gitleaks](https://github.com/gitleaks/gitleaks)
- [Snyk docs](https://docs.snyk.io/)
- [TruffleHog](https://github.com/trufflesecurity/trufflehog)
- [Trivy docs](https://trivy.dev/)
```

- [ ] **Step 2: Commit**

```bash
git add cicd-pipelines-labs/labs/lab-005-seguranca-pipelines/README.md
git commit -m "feat: adiciona lab-005 Seguranca em Pipelines"
git push
```

---

## Task 7: Lab 006 — Pipeline Completo (Desafio)

**Files:**
- Create: `cicd-pipelines-labs/labs/lab-006-pipeline-completo-desafio/README.md`

**Fonte:** https://github.com/toolbox-playground/pipelines-exemplo-basico-desafio

- [ ] **Step 1: Criar o README do lab**

Criar `cicd-pipelines-labs/labs/lab-006-pipeline-completo-desafio/README.md` com este conteúdo:

```markdown
# Lab 006 — Pipeline Completo: GitHub Actions + Docker + GCP + SonarCloud + Snyk (Desafio)

## Objetivo

Montar um pipeline GitHub Actions completo de ponta a ponta: build, testes, push de imagem
Docker, análise de qualidade com SonarCloud, scan de segurança com Snyk e deploy na
Google Cloud Run usando Workload Identity Federation (sem chave de serviço em plain text).

## Duração e dificuldade

- Duração estimada: 90 a 120 minutos
- Dificuldade: avançado

## Pré-requisitos

- Conta no GitHub
- Conta no Docker Hub — crie um repositório chamado `pipelines-exemplo-basico-desafio`
- Conta gratuita no SonarCloud ([sonarcloud.io](https://sonarcloud.io/)) — integração com GitHub
- Conta gratuita no Snyk ([snyk.io](https://snyk.io/))
- Projeto no Google Cloud Platform com billing ativo (necessário para Cloud Run)
- Node.js instalado localmente (para testar antes do push)

## Repositório de referência

[toolbox-playground/pipelines-exemplo-basico-desafio](https://github.com/toolbox-playground/pipelines-exemplo-basico-desafio)

## Visão geral do pipeline

```
push/PR
  │
  ├─ [paralelo] SonarCloud — análise de qualidade
  ├─ [paralelo] Snyk — scan de dependências
  │
  └─ build
       │
       test
         │
         docker build + push → Docker Hub
           │
           docker pull + run (smoke test)
             │
             deploy → Google Cloud Run
```

## Fluxo recomendado do aluno

### 1. Fazer fork e clonar

```bash
# Fork via GitHub UI, depois:
git clone https://github.com/<seu-usuario>/pipelines-exemplo-basico-desafio
cd pipelines-exemplo-basico-desafio
```

### 2. Testar a aplicação localmente

```bash
npm install
npm test
```

### 3. Configurar os Secrets no repositório GitHub

Vá em **Settings > Secrets and variables > Actions > New repository secret** e crie:

| Secret | Onde obter |
|---|---|
| `DOCKER_USERNAME` | Seu usuário do Docker Hub |
| `DOCKER_PASSWORD` | Token em [hub.docker.com/settings/security](https://hub.docker.com/settings/security) |
| `SNYK_TOKEN` | Token em [app.snyk.io/account](https://app.snyk.io/account) |
| `SONAR_TOKEN` | Token gerado no SonarCloud após importar o projeto |
| `SONAR_ORG` | Nome da organização no SonarCloud |
| `SONAR_PROJECT_KEY` | Chave do projeto no SonarCloud |
| `SONAR_PROJECT_NAME` | Nome do projeto no SonarCloud |
| `WORKLOAD_IDENTIFIER_PROVIDER` | URL do Pool do WIF (criado no passo 6) |
| `SERVICE_ACCOUNT` | Conta de serviço GCP (criada no passo 6) |

### 4. Configurar as Variables do repositório

Vá em **Settings > Secrets and variables > Actions > Variables > New repository variable**:

| Variable | Valor |
|---|---|
| `DOCKER_REGISTRY` | `docker.io` |
| `DOCKER_NAMESPACE` | Seu namespace/usuário no Docker Hub |
| `DOCKER_REPOSITORY` | `pipelines-exemplo-basico-desafio` |
| `CLOUD_RUN_SERVICE_NAME` | `nodejs-toolbox-playground-desafio` |

### 5. Configurar SonarCloud

1. Acesse [sonarcloud.io](https://sonarcloud.io/) e faça login com o GitHub.
2. Clique em **+** (Analyze new project) e importe o fork do repositório.
3. Desative a análise automática (usaremos o GitHub Actions manualmente).
4. Em **My Account > Security**, gere um token e salve como `SONAR_TOKEN` no GitHub.
5. Copie a `Organization key`, `Project Key` e `Project Name` para os demais secrets.

### 6. Configurar GCP — Workload Identity Federation

O WIF permite que o GitHub Actions autentique no GCP **sem** armazenar chaves de serviço como secrets.

```bash
# Criar o pool de identidade
gcloud iam workload-identity-pools create github-toolbox-actions-pool \
  --location="global" \
  --description="Pool para autenticar GitHub Actions" \
  --display-name="GitHub Actions Pool"

# Criar o provider dentro do pool
# Substitua <seu-usuario> pelo seu usuário GitHub
gcloud iam workload-identity-pools providers create-oidc github-provider \
  --location="global" \
  --workload-identity-pool="github-toolbox-actions-pool" \
  --display-name="GitHub provider" \
  --attribute-mapping="google.subject=assertion.sub,attribute.repository=assertion.repository,attribute.repository_owner=assertion.repository_owner" \
  --issuer-uri="https://token.actions.githubusercontent.com" \
  --attribute-condition="assertion.repository_owner == '<seu-usuario>'"
```

Após criar, obtenha a URL do provider e salve como `WORKLOAD_IDENTIFIER_PROVIDER` no GitHub:

```bash
gcloud iam workload-identity-pools providers describe github-provider \
  --location="global" \
  --workload-identity-pool="github-toolbox-actions-pool" \
  --format="value(name)"
```

Crie ou use uma conta de serviço GCP com as permissões:
- `roles/run.admin`
- `roles/iam.serviceAccountUser`
- `roles/artifactregistry.admin`

Salve o email da conta de serviço como `SERVICE_ACCOUNT` no GitHub.

> **Referência completa:** [Secure your use of third party tools with identity federation](https://cloud.google.com/blog/products/identity-security/secure-your-use-of-third-party-tools-with-identity-federation)

### 7. Disparar o pipeline

Com todos os secrets configurados, faça um push:

```bash
echo "## Testado por <seu-nome>" >> README.md
git add README.md
git commit -m "test: dispara pipeline completo"
git push
```

Acompanhe em **Actions**: todos os 7 jobs devem finalizar com sucesso (ícone verde).

### 8. Verificar o deploy na Cloud Run

```bash
gcloud run services list --platform managed --region us-central1
```

Ou acesse o [Console do Cloud Run](https://console.cloud.google.com/run) e abra a URL do serviço `nodejs-toolbox-playground-desafio`.

## Como demonstrar em aula (roteiro curto)

1. **[10 min]** Mostrar o `main.yml` completo e explicar os jobs paralelos (SonarCloud, Snyk) vs. sequenciais (build → test → docker → deploy).
2. **[10 min]** Configurar os secrets e variables ao vivo no GitHub.
3. **[10 min]** Fazer push e acompanhar o pipeline rodar.
4. **[10 min]** Mostrar o resultado no Docker Hub, no SonarCloud e no Snyk.
5. **[10 min]** Acessar o serviço na Cloud Run via URL pública.

## Referências

- [Repositório de referência](https://github.com/toolbox-playground/pipelines-exemplo-basico-desafio)
- [Workload Identity Federation](https://cloud.google.com/iam/docs/workload-identity-federation)
- [Deploy to Cloud Run — GitHub Action](https://github.com/marketplace/actions/deploy-to-cloud-run)
- [SonarCloud — GitHub Actions integration](https://sonarcloud.io/documentation/analysis/github-integration/)
- [Snyk GitHub Actions](https://github.com/snyk/actions)
```

- [ ] **Step 2: Commit**

```bash
git add cicd-pipelines-labs/labs/lab-006-pipeline-completo-desafio/README.md
git commit -m "feat: adiciona lab-006 Pipeline Completo desafio GCP GitHub Actions"
git push
```

---

## Verificação end-to-end

Após implementar todos os tasks:

```bash
# Verificar estrutura criada
find cicd-pipelines-labs -type f | sort

# Verificar link no root README
grep -i "cicd\|pipeline" README.md

# Verificar que todos os READMEs existem
for lab in lab-001 lab-002 lab-003 lab-004 lab-005 lab-006; do
  test -f "cicd-pipelines-labs/labs/$lab-*/README.md" && echo "$lab OK" || echo "$lab FALTANDO"
done
```
