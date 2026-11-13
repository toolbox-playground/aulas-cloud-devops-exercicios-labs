# Lab 011 - Terraform com agente de IA: plan quebrado e mudança com destruição

## Objetivo

Usar o **Claude Code** ou o **Codex** em duas situações de Terraform:

1. **Troubleshooting:** depois de um refactor, o `terraform plan` passou a falhar. O agente investiga, encontra a causa e propõe a correção, sem rodar `apply`.
2. **Mudança com risco:** você pede uma alteração que força a recriação de um recurso. O agente roda o plan, percebe a destruição, tenta evitá-la, roda o plan de novo e explica o impacto. O `apply` fica com você.

O provider é o `hashicorp/local`: o Terraform só gera arquivos em `workspace/saida/`. Nada é criado em nuvem.

## Dificuldade e tempo

- Dificuldade: Intermediário
- Tempo estimado: 10 a 15 minutos

## Pré-requisitos

| Ferramenta | Como conferir |
|---|---|
| Terraform 1.6 ou mais novo | `terraform version` |
| Acesso à internet na primeira execução (download do provider) | — |
| Claude Code **ou** Codex instalado e autenticado | `claude --version` ou `codex --version` |

## Passo a passo

### 1. Preparar o estado inicial e provocar a falha

O script roda `terraform init`, aplica o estado inicial, confirma que o plan está limpo (`No changes`) e então injeta a falha.

```bash
cd artificial-intelligence-labs/labs/lab-011-terraform-troubleshooting-ia
bash scripts/setup.sh --state broken
cd workspace && terraform plan; cd ..
```

O `plan` agora termina com erro.

### 2. Parte 1 · troubleshooting do plan

```bash
cd workspace
claude      # ou: codex
```

```text
Depois de um refactor no repositório, o terraform plan deste diretório começou a falhar.
Investigue a causa com os comandos do Terraform e lendo os arquivos, sem rodar apply.
Mostre a evidência, proponha a menor correção e espere minha aprovação. Depois de aplicar
a correção no código, confirme que o plan volta a não ter mudanças.
```

O `AGENTS.md` e o `CLAUDE.md` do workspace dizem ao agente que ele pode rodar `validate`, `fmt` e `plan`, mas nunca `apply` nem `destroy`.

O que o agente deve encontrar: o `plan` falha em `templatefile` com `no file exists at "./templates/nginx.conf.tftpl"`, e o arquivo existe com outro nome (`templates/proxy.conf.tftpl`). Causa: o template foi renomeado e o `main.tf` não foi atualizado. As correções mínimas são atualizar o caminho no `main.tf` ou voltar o nome do arquivo. Quando ele propuser, aprove:

```text
Aprovado. Aplique essa correção no código e rode o terraform plan de novo, sem apply.
```

Não vale: rodar `apply`, apagar o state ou trocar o template por conteúdo fixo.

Confira depois da correção (o plan deve dizer `No changes`) (saia do agente antes: `/exit` no Claude Code, `Ctrl+C` no Codex):

```bash
cd .. && bash scripts/verify.sh --state healthy && cd workspace
```

### 3. Parte 2 · mudança que destrói um recurso

Na mesma sessão (ou numa nova), peça:

```text
Renomeie o arquivo gerado pelo recurso app_env de app.env para pedidos-api.env.
Rode terraform plan. Se o plan destruir algum recurso, tente evitar a destruição e rode o
plan de novo; se não for possível, me explique o impacto. Não rode apply.
```

Observe o loop: o agente edita, roda o plan, lê `Plan: 1 to add, 0 to change, 1 to destroy`, tenta uma alternativa (por exemplo `create_before_destroy`), roda o plan de novo e explica. Mudar o `filename` de um `local_file` sempre força a recriação: `create_before_destroy` só muda a ordem, e um bloco `moved` não resolve. O esperado é ele explicar o impacto e deixar o `apply` com você.

### 4. Repetir ou limpar

```bash
cd ..
bash scripts/reset.sh --state broken   # volta ao plan quebrado e desfaz edições nos .tf
bash scripts/teardown.sh               # apaga saida/, state e .terraform deste lab
```

## Critério de conclusão

- Parte 1: causa explicada com a mensagem de erro do plan; correção mínima; `verify.sh --state healthy` passa (`No changes`).
- Parte 2: o agente identificou a destruição no plan e não rodou `apply`.

## Referências

- [terraform plan](https://developer.hashicorp.com/terraform/cli/commands/plan)
- [templatefile](https://developer.hashicorp.com/terraform/language/functions/templatefile)
- [lifecycle: create_before_destroy](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)
- Aula 04-5 do curso: casos de uso em infraestrutura.
