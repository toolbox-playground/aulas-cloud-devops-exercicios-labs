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

Aguarde a inicialização e acesse [http://localhost:8080](http://localhost:8080).
Login: `admin` / `password`

### 3. Configurar credenciais

1. Vá em **Gerenciar Jenkins > Credentials > System > Global credentials > Add Credentials**.

2. **Credencial do GitHub**:
   - Kind: `Username with password`
   - Username: seu usuário GitHub
   - Password: token gerado em [github.com/settings/tokens/new?scopes=repo,user](https://github.com/settings/tokens/new?scopes=repo,user)
   - ID: `toolboxgithub`

3. **Credencial do Docker Hub**:
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

O Jenkins escaneia o repositório e dispara o pipeline automaticamente.

### 5. Acompanhar o pipeline

1. Aguarde o scan terminar e clique em **Pipeline Jenkins > main**.
2. Em **Histórico de Compilações**, acompanhe o build em andamento.
3. Quando finalizar, verifique no Docker Hub que a imagem foi publicada.

### 6. Desafio (opcional)

Na pasta `nodejs/` do repositório há uma aplicação Node.js com seu próprio `Dockerfile` e `Jenkinsfile`. Tente criar um segundo job apontando o Script Path para `nodejs/Jenkinsfile`.

## Como demonstrar em aula (roteiro curto)

1. **[5 min]** Mostrar o `DockerfileJenkins` e explicar a montagem do socket do Docker.
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
- [jenkins/jenkins:lts-jdk17 — Docker Hub](https://hub.docker.com/r/jenkins/jenkins/)
- [Jenkins Multibranch Pipeline](https://www.jenkins.io/doc/book/pipeline/multibranch/)
