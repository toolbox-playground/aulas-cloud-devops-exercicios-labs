# Lab 005 — Segurança em Pipelines

## Objetivo

Explorar 5 ferramentas de segurança integráveis em pipelines CI/CD: Checkov (IaC),
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

### 2. Checkov — varredura de IaC

O Checkov analisa arquivos Terraform, CloudFormation, Kubernetes e outros para identificar
configurações inseguras antes do deploy.

```bash
cd checkov
```

Siga as instruções do README dentro da pasta `checkov/`. Comando rápido via Docker:

```bash
docker run --rm -v $(pwd):/tf bridgecrew/checkov -d /tf
```

**O que observar:** resultados PASSED/FAILED por recurso, com o ID da regra (ex: `CKV_AWS_23`) e o arquivo/linha que falhou.

### 3. Gitleaks — detecção de segredos no histórico Git

O Gitleaks escaneia commits em busca de senhas, tokens e chaves de API acidentalmente commitados.

```bash
cd ../gitleaks
```

Siga as instruções do README dentro da pasta `gitleaks/`. Comando rápido via Docker:

```bash
docker run --rm -v $(pwd):/repo zricethezav/gitleaks detect --source /repo -v
```

**O que observar:** cada "finding" com o arquivo, linha, tipo de segredo e o commit onde apareceu.

### 4. Snyk — vulnerabilidades em dependências

O Snyk verifica se as bibliotecas do projeto possuem CVEs conhecidos.

```bash
cd ../snyk
```

Siga as instruções do README dentro da pasta `snyk/`. Alternativa via npm:

```bash
npm install -g snyk
snyk auth    # abre o browser para autenticação
snyk test
```

**O que observar:** vulnerabilidades por severidade (Critical/High/Medium/Low), versão afetada e versão corrigida.

### 5. TruffleHog — detecção de segredos por entropia

O TruffleHog usa análise de entropia e regex para encontrar segredos em repositórios,
inclusive em branches antigas ou arquivos deletados.

```bash
cd ../trufflehog
```

Siga as instruções do README dentro da pasta `trufflehog/`. Comando rápido via Docker:

```bash
docker run --rm trufflesecurity/trufflehog:latest github \
  --repo https://github.com/toolbox-playground/pipelines-seguranca-exemplo-basico
```

**O que observar:** cada segredo encontrado com o tipo (AWS Key, GitHub Token etc.), o commit e a branch de origem.

### 6. Trivy — varredura de imagens de container

O Trivy verifica imagens Docker em busca de CVEs em pacotes do sistema operacional e dependências.

```bash
cd ../trivy
```

Siga as instruções do README dentro da pasta `trivy/`. Comando rápido via Docker:

```bash
docker run --rm aquasec/trivy image nginx:latest
```

**O que observar:** vulnerabilidades por pacote, severidade e a versão com correção disponível.

### 7. Comparativo das ferramentas

| Ferramenta | O que escaneia | Quando usar no pipeline |
|---|---|---|
| Checkov | IaC (Terraform, K8s, etc.) | Antes de aplicar infraestrutura |
| Gitleaks | Histórico Git (segredos) | Em cada push / PR |
| Snyk | Dependências (npm, pip, maven) | Em cada build |
| TruffleHog | Histórico Git (segredos, entropia) | Auditoria de repositório |
| Trivy | Imagens Docker | Antes de publicar no registry |

## Como demonstrar em aula (roteiro curto)

1. **[5 min]** Explicar o modelo shift-left: detectar problemas de segurança antes do deploy.
2. **[5 min]** Rodar o Gitleaks e mostrar um finding detectado.
3. **[5 min]** Rodar o Trivy em uma imagem pública e mostrar os CVEs.
4. **[5 min]** Rodar o Snyk num projeto Node.js e mostrar a listagem de vulnerabilidades.
5. **[5 min]** Mostrar como cada ferramenta pode ser um step dentro do GitHub Actions.

## Referências

- [Repositório de referência](https://github.com/toolbox-playground/pipelines-seguranca-exemplo-basico)
- [Checkov](https://www.checkov.io/)
- [Gitleaks](https://github.com/gitleaks/gitleaks)
- [Snyk](https://docs.snyk.io/)
- [TruffleHog](https://github.com/trufflesecurity/trufflehog)
- [Trivy](https://trivy.dev/)
