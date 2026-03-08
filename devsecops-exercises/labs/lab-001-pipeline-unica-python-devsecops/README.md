# Lab 001 - Pipeline Única DevSecOps (versão enxuta)

## Objetivo

Praticar correção de falhas de segurança em um fluxo real de PR, usando a pipeline do repositório `caio-sec`.

## Repositório base

- https://github.com/toolbox-playground/caio-sec

## O que você vai praticar

- Encontrar problemas de segurança na codebase.
- Corrigir incrementalmente em uma branch própria.
- Abrir PR e acompanhar os checks de segurança.
- Iterar até os checks passarem conforme esperado.

## Passo a passo do aluno

1. Faça fork do repositório **ou** use uma branch no repositório principal.
2. Crie uma branch de trabalho:

```bash
git checkout -b hotfix/lab-001-seu-nome
```

3. Faça alterações de correção nos arquivos que os scanners apontarem.
4. Commit incremental (um bloco de correções por vez):

```bash
git add .
git commit -m "fix(lab-001): corrigir <tema>"
```

5. Faça push da branch:

```bash
git push -u origin hotfix/lab-001-seu-nome
```

6. Abra PR para `main`.
7. Acompanhe os checks no GitHub Actions (security, summary, ci, cd).
8. Se algum check falhar:
   - leia o log do job,
   - identifique arquivo/linha,
   - aplique correção,
   - faça novo commit e push.
9. Repita até a pipeline refletir as correções esperadas.

## Dica de execução

- Trabalhe em ciclos curtos: **corrige -> push -> vê check -> corrige de novo**.
- Foque primeiro nos jobs de segurança (Checkov, Gitleaks, TruffleHog, Trivy).

## Exemplo de PR resolvendo o lab (colinha)

Se travar para encontrar todos os pontos, use este PR como referência:

- https://github.com/toolbox-playground/caio-sec/pull/1

Use apenas como guia. O ideal é você tentar localizar e corrigir os problemas por conta própria antes de consultar a referência.
