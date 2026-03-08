# Lab 001 - Pipeline Única DevSecOps

## Objetivo

Praticar um ciclo completo de DevSecOps em PR real: **detectar -> corrigir -> validar -> repetir**.

## Duração e dificuldade

- Duração estimada: 30 a 45 minutos
- Dificuldade: iniciante a intermediário

## Repositório base

- https://github.com/toolbox-playground/caio-sec

## Contexto da prática

Você vai trabalhar com uma pipeline unificada que roda segurança antes de CI/CD.
O foco do lab não é “passar de primeira”, e sim aprender a ler os resultados dos scanners e corrigir com commits incrementais.

## O que será praticado

- Leitura de findings nos checks (Checkov, Gitleaks, TruffleHog, Trivy)
- Correção de problemas de segurança na codebase
- Abertura e evolução de PR com feedback contínuo da pipeline
- Validação de progresso no `Summary` e nos logs dos jobs

## Fluxo recomendado do aluno

1. Faça fork do repositório **ou** use uma branch no repositório principal.
2. Crie sua branch de trabalho:

```bash
git checkout -b hotfix/lab-001-seu-nome
```

3. Abra um PR cedo (mesmo incompleto), para já visualizar os checks.
4. Corrija um bloco por vez (ex.: segredos, depois dependências, depois código).
5. Faça commits pequenos e descritivos:

```bash
git add .
git commit -m "fix(lab-001): corrigir <tema>"
git push -u origin hotfix/lab-001-seu-nome
```

6. A cada falha de check:
   - abra o job no Actions,
   - leia arquivo/linha reportados,
   - aplique correção,
   - commit/push novamente.
7. Repita até atingir o comportamento esperado da pipeline.

## Como demonstrar em aula (roteiro curto)

1. Rodar baseline e mostrar os checks.
2. Escolher 1 finding e corrigir ao vivo.
3. Pushar e mostrar impacto imediato no PR.
4. Repetir com mais 1 ou 2 findings.
5. Encerrar com comparação antes/depois do `Summary`.

## Dicas práticas

- Trabalhe em ciclos curtos: **corrige -> push -> verifica check**.
- Comece pelos jobs de segurança; depois valide CI/CD.
- Não tente corrigir tudo num único commit.

## PR referência (colinha)

Se você travar para encontrar todos os ajustes, use como guia:

- https://github.com/toolbox-playground/caio-sec/pull/1

Use essa referência para comparação de abordagem, mas tente resolver primeiro por conta própria.
