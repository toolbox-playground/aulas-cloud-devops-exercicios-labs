# Lab 000 - Primeiros Passos com Terraform

## Objetivo

Entender o ciclo básico do Terraform escrevendo seus primeiros arquivos de configuração e executando os comandos essenciais: `init`, `plan`, `apply` e `destroy`.

## Duração e dificuldade

- Duração estimada: 15 a 25 minutos
- Dificuldade: iniciante

## Repositório base

- [terraform-dominando-iac — labs/lab-000-terraform-primeiros-passos](https://github.com/toolbox-playground/terraform-dominando-iac/tree/main/labs/lab-000-terraform-primeiros-passos)

## Pré-requisitos

- [Terraform](https://developer.hashicorp.com/terraform/install) instalado (versão 1.0+)

Nenhuma conta de cloud, Docker ou dependência externa é necessária. Tudo roda localmente.

Verifique se o Terraform está instalado:

```bash
terraform version
```

## Fluxo recomendado do aluno

1. Clone o repositório base e acesse o lab:

```bash
git clone https://github.com/toolbox-playground/terraform-dominando-iac.git
cd terraform-dominando-iac/labs/lab-000-terraform-primeiros-passos
```

2. Inicialize o projeto:

```bash
terraform init
```

3. Visualize o que será criado:

```bash
terraform plan
```

4. Aplique a infraestrutura:

```bash
terraform apply
```

5. Verifique o arquivo criado na pasta `output/`:

```bash
cat output/meu-primeiro-arquivo.txt
```

6. Edite `terraform.tfvars`, mude a mensagem e rode `plan` + `apply` novamente para ver o ciclo de atualização.

7. Ao final, destrua os recursos:

```bash
terraform destroy
```

## Como demonstrar em aula (roteiro curto)

1. Mostrar os 4 arquivos `.tf` e explicar o papel de cada um.
2. Rodar `terraform init` e mostrar a pasta `.terraform/` criada.
3. Rodar `terraform plan` e ler o output junto com os alunos.
4. Rodar `terraform apply` e mostrar o arquivo criado em `output/`.
5. Editar `terraform.tfvars` e repetir `plan` + `apply` para mostrar o `~` de modificação.
6. Encerrar com `terraform destroy` para reforçar o ciclo completo.

## Dicas práticas

- Sempre revise o `plan` antes do `apply`.
- O arquivo `terraform.tfstate` é o "inventário" do Terraform — nunca edite manualmente.
- O diretório `.terraform/` não precisa ir para o git — em projetos reais fica no `.gitignore`.

## Referência

- Código completo do exercício: [abrir](https://github.com/toolbox-playground/terraform-dominando-iac/tree/main/labs/lab-000-terraform-primeiros-passos)
