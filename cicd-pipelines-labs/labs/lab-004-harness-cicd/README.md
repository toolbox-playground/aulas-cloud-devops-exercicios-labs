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
2. No campo de nome, adicione `-fork` ao final: `pipelines-harness-exemplo-basico-fork`.
3. Clone e edite `.harness/pipelines/toolboxplaygroundharness.yaml`:
   - Localize `repo: toolboxplayground/pipelines-harness-exemplo-basico`
   - Substitua `toolboxplayground` pelo seu usuário/namespace do Docker Hub.
4. Faça commit e push:

```bash
git add .harness/pipelines/toolboxplaygroundharness.yaml
git commit -m "config: atualiza namespace do Docker Hub"
git push
```

### 2. Criar os tokens necessários

**GitHub Personal Access Token:**

Acesse [github.com/settings/tokens/new?scopes=repo,user,admin:org_hook,admin:repo_hook](https://github.com/settings/tokens/new?scopes=repo,user,admin:org_hook,admin:repo_hook), em **Note** coloque `Harness` e clique em **Generate token**. Copie o token.

**Docker Hub Access Token:**

Acesse [hub.docker.com/settings/security](https://hub.docker.com/settings/security) > **New Access Token**, description: `Harness Token`. Copie o token.

### 3. Habilitar Bi-Directional Sync no Harness

1. No Harness, clique na caixa de seleção no canto superior esquerdo > **Accounts** > sua conta.
2. Vá em **Account Settings > Default Settings > Git Experience**.
3. Marque **Enable Bi-Directional Sync** e salve.

### 4. Criar conector GitHub

1. **Projects > Default Project > Project Settings > Connectors > New Connector**.
2. Busque `GitHub` e selecione.
3. Name: `Toolbox_GitHub` | GitHub Account URL: `https://github.com/<seu-usuario>`
4. Test Repository: `pipelines-harness-exemplo-basico`
5. Authentication: Username = seu usuário GitHub.
   - Password: clique em **Create or Select a Secret > New Secret Text**, Name: `GitHub PAT`, Value: cole o token. Salve.
6. Marque **Enable API access** e selecione o secret `GitHub PAT`.
7. Connect through: **Harness Platform**. Salve e aguarde **Verification successful**.

### 5. Criar conector Docker Hub

1. **New Connector** > busque `Docker Registry`.
2. Name: `Docker_Toolbox` | Provider Type: `DockerHub`
3. Docker Registry URL: `https://index.docker.io/v2/`
4. Username: seu usuário Docker Hub.
   - Password: clique em **Create or Select a Secret > New Secret Text**, Name: `Docker Token`, Value: cole o token. Salve.
5. Connect through: **Harness Platform**. Salve e aguarde **Verification successful**.

### 6. Importar a pipeline

1. **Pipelines > seta ao lado de "+ Create a Pipeline" > Import from Git**.
2. Git provider: **Third-party Git provider**.
3. Git Connector: `Toolbox_GitHub` | Repository: `pipelines-harness-exemplo-basico-fork`
4. Git Branch: `main` | YAML Path: `.harness/pipelines/toolboxplaygroundharness.yaml`
5. Clique em **Import**.

### 7. Configurar a infraestrutura (Harness Cloud)

1. Abra a pipeline importada e clique em **NodeJS > Infrastructure > Update Card**.
2. Adicione um cartão de crédito (não haverá cobrança no plano free — 100 builds/mês).
3. Selecione **Cloud** e clique em **Continue**.

> Se preferir não cadastrar cartão, use a opção **Local** seguindo:
> [developer.harness.io/docs/continuous-integration/use-ci/set-up-build-infrastructure/define-a-docker-build-infrastructure](https://developer.harness.io/docs/continuous-integration/use-ci/set-up-build-infrastructure/define-a-docker-build-infrastructure/)

### 8. Importar Input Sets e criar Triggers

**Input Set — Pull Request:**
- **Input Sets > New Input Set > seta > Import From Git**
- Name: `pipelines-harness-exemplo-basico-pr-trigger-input-set`
- YAML Path: `.harness/pipelines-harness-exemplo-basico-pr-trigger-input-set.yaml` → **Import**

**Input Set — Push:**
- **New Input Set > Import From Git**
- Name: `pipelines-harness-exemplo-basico-push-trigger-input-set`
- YAML Path: `.harness/pipelines-harness-exemplo-basico-push-trigger-input-set.yaml` → **Import**

**Trigger Push:**
- **Triggers > New Trigger > GitHub (Webhook)**
- Name: `Push Trigger` | Connector: `Toolbox_GitHub` | Repository: `pipelines-harness-exemplo-basico-fork` | Event: **Push**
- Pipeline Input: selecione o input set de push → **Create Trigger**

**Trigger Pull Request:**
- **New Trigger > GitHub (Webhook)**
- Name: `PR Trigger` | Connector: `Toolbox_GitHub` | Repository: `pipelines-harness-exemplo-basico-fork` | Event: **Pull Request**
- Pipeline Input: selecione o input set de PR → **Create Trigger**

### 9. Testar a pipeline

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
- [Configure Docker build infrastructure](https://developer.harness.io/docs/continuous-integration/use-ci/set-up-build-infrastructure/define-a-docker-build-infrastructure/)
