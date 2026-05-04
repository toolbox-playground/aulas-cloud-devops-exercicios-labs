# Lab 001 - Terraform com GCP

## Objetivo

Provisionar uma instância Compute Engine no Google Cloud usando Terraform, praticando o ciclo completo de IaC: `init`, `plan`, `apply`, modificação e `destroy`.

## Duração e dificuldade

- Duração estimada: 20 a 35 minutos
- Dificuldade: iniciante

## Repositório base

- [terraform-dominando-iac — labs/lab-001-terraform-gcp](https://github.com/toolbox-playground/terraform-dominando-iac/tree/main/labs/lab-001-terraform-gcp)

## Referência do exercício

Este lab é baseado no lab oficial do Google Skills:
- [Infrastructure as Code with Terraform — Google Skills #4981](https://www.skills.google/catalog_lab/4981)

## Pré-requisitos

- Conta GCP com um projeto ativo e billing habilitado
- [Terraform](https://developer.hashicorp.com/terraform/install) instalado (versão 1.0+)
- [gcloud CLI](https://cloud.google.com/sdk/docs/install) autenticado, **ou** use o Google Cloud Shell (Terraform já vem pré-instalado)

Autentique o Terraform com sua conta GCP:

```bash
gcloud auth application-default login
```

## Fluxo recomendado do aluno

1. Clone o repositório e acesse o lab:

```bash
git clone https://github.com/toolbox-playground/terraform-dominando-iac.git
cd terraform-dominando-iac/labs/lab-001-terraform-gcp
```

2. Edite o arquivo `terraform.tfvars` e preencha o seu `project_id`:

```hcl
project_id = "SEU-PROJECT-ID-AQUI"
```

3. Inicialize o projeto:

```bash
terraform init
```

4. Visualize o que será criado:

```bash
terraform plan
```

5. Aplique a infraestrutura:

```bash
terraform apply
```

6. Verifique os outputs (nome e IP da instância criada) e confirme no Console do GCP.

7. **Modifique** o `terraform.tfvars` — adicione tags de rede e mude o `machine_type` para `e2-medium` — e rode novamente `plan` + `apply` para ver o ciclo de atualização.

8. Ao final, destrua os recursos:

```bash
terraform destroy
```

## Como demonstrar em aula (roteiro curto)

1. Mostrar os arquivos `.tf` e explicar o provider `google` e o resource `google_compute_instance`.
2. Rodar `terraform init` e mostrar o download do provider GCP.
3. Rodar `terraform plan` e ler o output junto com os alunos.
4. Rodar `terraform apply` e abrir o Console GCP para mostrar a VM criada.
5. Alterar `machine_type` no `tfvars` e mostrar o `~` (update) no `plan`.
6. Encerrar com `terraform destroy` para reforçar o ciclo completo.

## Dicas práticas

- Sempre revise o `plan` antes do `apply` — especialmente em contas reais com custo.
- Não esqueça de rodar `terraform destroy` ao final para evitar cobranças.
- O `project_id` é diferente do nome do projeto — encontre em: Console GCP → selecione o projeto → ID aparece no topo da página.

## Referência

- Código completo do exercício: [abrir](https://github.com/toolbox-playground/terraform-dominando-iac/tree/main/labs/lab-001-terraform-gcp)
- Lab Google Skills: [Infrastructure as Code with Terraform](https://www.skills.google/catalog_lab/4981)
