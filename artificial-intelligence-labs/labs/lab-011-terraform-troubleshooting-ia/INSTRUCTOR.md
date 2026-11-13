# Lab 011 · guia do instrutor (gabarito)

## Falha injetada (parte 1)

`scripts/inject-fault.sh template-renomeado` renomeia `templates/nginx.conf.tftpl` para `templates/proxy.conf.tftpl`. O `main.tf` continua chamando `templatefile(".../templates/nginx.conf.tftpl", ...)`: um refactor incompleto.

Saída real do plan (ensaio de 13/11/2026, Terraform 1.13.1):

```text
│ while calling templatefile(path, vars)
│ path.module is "."

Invalid value for "path" parameter: no file exists at
"./templates/nginx.conf.tftpl"; ...
```

Correções aceitáveis (mínimas): atualizar o caminho no `main.tf` para `proxy.conf.tftpl` **ou** voltar o nome do arquivo. Em ambas, o plan volta a `No changes`, porque o conteúdo gerado não muda.

Não aceitar: rodar `apply`, apagar o state ou trocar o `templatefile` por conteúdo fixo.

## Parte 2 · comportamento esperado

Mudar o `filename` de um `local_file` força a substituição do recurso (`-/+`, `1 to add, 0 to change, 1 to destroy`). `create_before_destroy` só muda a ordem e um bloco `moved` não resolve, porque o endereço do recurso não muda. O agente deve explicar isso e deixar o `apply` com você.

Num ensaio real equivalente (sessão do Claude Code usada na aula 04-5), o agente editou, rodou o plan, viu `1 to destroy`, tentou `create_before_destroy`, rodou o plan de novo, reverteu a tentativa e explicou o impacto sem aplicar.

## Ensaio dos scripts (13/11/2026)

| Etapa | Resultado |
|---|---|
| `setup.sh --state broken` | init + apply inicial → `No changes` → falha injetada → plan com `no file exists` |
| Correção (voltar o nome do template) | `verify.sh --state healthy` → `No changes` |
| `reset.sh --state broken` | plan quebrado de novo |
| `teardown.sh` | `saida/`, state e `.terraform` removidos |
