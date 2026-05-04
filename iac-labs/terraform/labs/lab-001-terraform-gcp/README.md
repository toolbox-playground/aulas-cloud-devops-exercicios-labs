# Lab 001 - Terraform com GCP

## Objetivo

Provisionar uma instância Compute Engine no Google Cloud usando Terraform, praticando o ciclo completo de IaC: `init`, `plan`, `apply`, modificação e `destroy`.

## Duração e dificuldade

- Duração estimada: 1 hora
- Dificuldade: iniciante

## Como executar

Este lab é realizado inteiramente no **Google Skills (Qwiklabs)**. O próprio Google fornece um ambiente GCP temporário com credenciais já configuradas — não é necessário ter conta GCP nem instalar nada localmente.

Acesse o lab pelo link abaixo e siga as instruções na plataforma:

- [Infrastructure as Code with Terraform — Google Skills #4981](https://www.skills.google/catalog_lab/4981)

## O que você vai praticar

- Verificar a instalação do Terraform no Cloud Shell
- Configurar o provider `google` no `main.tf`
- Criar uma instância Compute Engine com `terraform apply`
- Modificar a infraestrutura (tags de rede e tipo de máquina)
- Destruir os recursos com `terraform destroy`
