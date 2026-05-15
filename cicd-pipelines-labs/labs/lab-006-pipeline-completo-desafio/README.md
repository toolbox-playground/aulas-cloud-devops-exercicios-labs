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
  ├─ [paralelo] SonarCloud — análise de qualidade de código
  ├─ [paralelo] Snyk — scan de vulnerabilidades nas dependências
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

### 1. Fazer fork e testar localmente

```bash
git clone https://github.com/<seu-usuario>/pipelines-exemplo-basico-desafio
cd pipelines-exemplo-basico-desafio
npm install
npm test
```

### 2. Configurar Secrets no repositório GitHub

Vá em **Settings > Secrets and variables > Actions > New repository secret**:

| Secret | Onde obter |
|---|---|
| `DOCKER_USERNAME` | Seu usuário do Docker Hub |
| `DOCKER_PASSWORD` | Token em [hub.docker.com/settings/security](https://hub.docker.com/settings/security) |
| `SNYK_TOKEN` | Token em [app.snyk.io/account](https://app.snyk.io/account) |
| `SONAR_TOKEN` | Token gerado no SonarCloud após importar o projeto |
| `SONAR_ORG` | Nome da organização no SonarCloud |
| `SONAR_PROJECT_KEY` | Chave do projeto no SonarCloud |
| `SONAR_PROJECT_NAME` | Nome do projeto no SonarCloud |
| `WORKLOAD_IDENTIFIER_PROVIDER` | URL do Pool do WIF (criado no passo 5) |
| `SERVICE_ACCOUNT` | Email da conta de serviço GCP (criado no passo 5) |

### 3. Configurar Variables do repositório

**Settings > Secrets and variables > Actions > Variables > New repository variable**:

| Variable | Valor |
|---|---|
| `DOCKER_REGISTRY` | `docker.io` |
| `DOCKER_NAMESPACE` | Seu usuário/namespace no Docker Hub |
| `DOCKER_REPOSITORY` | `pipelines-exemplo-basico-desafio` |
| `CLOUD_RUN_SERVICE_NAME` | `nodejs-toolbox-playground-desafio` |

### 4. Configurar SonarCloud

1. Acesse [sonarcloud.io](https://sonarcloud.io/) e faça login com GitHub.
2. Clique em **+** > **Analyze new project** e importe o fork.
3. Desative a análise automática (usaremos o GitHub Actions manualmente).
4. Em **My Account > Security**, gere um token e salve como `SONAR_TOKEN` no GitHub.
5. Copie a Organization key, Project Key e Project Name para os demais secrets.

### 5. Configurar GCP — Workload Identity Federation

O WIF permite que o GitHub Actions autentique no GCP sem armazenar chaves de serviço como secrets.

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

Obtenha a URL do provider e salve como `WORKLOAD_IDENTIFIER_PROVIDER`:

```bash
gcloud iam workload-identity-pools providers describe github-provider \
  --location="global" \
  --workload-identity-pool="github-toolbox-actions-pool" \
  --format="value(name)"
```

Crie uma conta de serviço GCP com as permissões abaixo e salve o email como `SERVICE_ACCOUNT`:

- `roles/run.admin`
- `roles/iam.serviceAccountUser`
- `roles/artifactregistry.admin`

### 6. Disparar o pipeline

```bash
echo "## Testado por <seu-nome>" >> README.md
git add README.md
git commit -m "test: dispara pipeline completo"
git push
```

Acompanhe em **Actions**: todos os jobs devem finalizar com ícone verde.

### 7. Verificar o deploy na Cloud Run

```bash
gcloud run services list --platform managed --region us-central1
```

Ou acesse o [Console do Cloud Run](https://console.cloud.google.com/run) e abra a URL do serviço.

## Como demonstrar em aula (roteiro curto)

1. **[10 min]** Mostrar o `main.yml` e explicar os jobs paralelos vs. sequenciais.
2. **[10 min]** Configurar os secrets e variables ao vivo no GitHub.
3. **[10 min]** Fazer push e acompanhar o pipeline rodar.
4. **[10 min]** Mostrar resultados no Docker Hub, SonarCloud e Snyk.
5. **[10 min]** Acessar o serviço na Cloud Run pela URL pública.

## Referências

- [Repositório de referência](https://github.com/toolbox-playground/pipelines-exemplo-basico-desafio)
- [Workload Identity Federation](https://cloud.google.com/iam/docs/workload-identity-federation)
- [Deploy to Cloud Run — GitHub Action](https://github.com/marketplace/actions/deploy-to-cloud-run)
- [SonarCloud — GitHub Actions integration](https://sonarcloud.io/documentation/analysis/github-integration/)
- [Snyk GitHub Actions](https://github.com/snyk/actions)
