# Lab 001 - Pipeline Única DevSecOps para App Python

## Objetivo

Demonstrar, em uma única pipeline CI/CD, como adicionar múltiplos checks de segurança em uma app Python simples e depois seguir para CI e CD (fake).

## Duração e dificuldade

- Duração estimada: 30 a 45 minutos
- Dificuldade: Iniciante a Intermediário

## Contexto do lab

Este lab usa o conceito de pipeline unificada para mostrar, na prática, como segurança pode vir antes de CI/CD sem quebrar o fluxo didático da aula.

Referência de implementação existente:

- https://github.com/toolbox-playground/caio-sec

## Resultado esperado da aula

Ao final, os alunos devem entender como uma pipeline pode:

1. Rodar varreduras de segurança primeiro.
2. Executar CI Python após os checks de segurança.
3. Executar um CD fake para simular pipeline real completa.
4. Detectar dependência vulnerável, secret hardcoded e SQL Injection.
5. Exibir evidências no PR (logs, alertas, status checks).

## Público-alvo (alunos)

- Professor: usar este guia como roteiro de demonstração ao vivo (30–45 min).
- Aluno: repetir os passos em branch própria e abrir PR para observar os checks.

## Chaves de acesso e plataformas externas

Para o fluxo principal da aula (gravada ou ao vivo), **não é obrigatório** abrir plataformas externas para pegar chaves.

- Funciona sem chaves: Checkov, Gitleaks, TruffleHog e Trivy.
- Opcionais (podem ser ignorados no lab rápido):
   - `SNYK_TOKEN`
   - `SONAR_TOKEN`
   - `SONAR_HOST_URL`

Se essas chaves não estiverem configuradas, o lab continua válido para demonstração.

## Arquitetura didática da pipeline (única)

1. Stage `security` (jobs paralelos)
   - Checkov, Gitleaks, TruffleHog, Trivy, Snyk (opcional), SonarQube (opcional)
2. Stage `security-summary`
   - consolidado didático dos resultados
3. Stage `python-ci`
   - setup Python, dependências, validação, testes (se existirem), build Docker
4. Stage `fake-cd`
   - simulação de deploy para ilustrar o CD sem deploy real

> Para aula curta, priorize dependências + segredos + code scanning.

## Passo a passo rápido (aula ao vivo)

### Passo 1 - Preparar repositório

1. Abra o repositório da demo (`caio-sec`) ou um fork.
2. Confirme que existe a app Python de exemplo em `examples/python/app.py`.
3. Confirme que a pipeline unificada está habilitada no GitHub Actions.

### Passo 2 - Rodar baseline

1. Execute pipeline sem inserir falhas novas.
2. Mostre no Actions os jobs de segurança, depois `python-ci`, depois `fake-cd`.
3. Explique rapidamente o que cada stage valida.

### Passo 3 - Exercício 1 (Dependência vulnerável)

Objetivo: mostrar scanner de dependências bloqueando/alertando no PR.

1. Crie branch de teste.
2. Altere `requirements.txt` para uma versão vulnerável (exemplo didático):

```text
flask==0.12.2
```

3. Abra PR.
4. Mostre o resultado no check de dependências.

Pergunta para os alunos:

- Qual dependência foi marcada como vulnerável e qual severidade?

### Passo 4 - Exercício 2 (Secret hardcoded)

Objetivo: mostrar detecção automática de segredos.

1. Na mesma branch, adicione um valor de secret fake no código ou `.env` de exemplo.
2. Abra/atualize PR.
3. Mostre o scanner de secrets reportando o problema.

Pergunta para os alunos:

- Em qual arquivo/linha o segredo foi detectado?

### Passo 5 - Exercício 3 (SQL Injection)

Objetivo: mostrar análise estática identificando risco de injeção.

1. Adicione um exemplo vulnerável (query montada por concatenação/f-string).
2. Abra/atualize PR.
3. Mostre alertas de code scanning (CodeQL/Sonar/SAST).

Pergunta para os alunos:

- Qual regra de segurança identificou a falha?

### Passo 6 - Correções rápidas

1. Atualize dependência para versão segura.
2. Remova segredo hardcoded e mova para secret/variável de ambiente.
3. Reescreva query com parâmetro seguro.
4. Reexecute pipeline e valide redução dos findings.

## Checklist de validação do lab

- Pipeline única executou com jobs de segurança, `python-ci` e `fake-cd`.
- Dependência vulnerável foi detectada no PR.
- Secret hardcoded foi detectado no PR.
- Vulnerabilidade de código (SQL Injection) foi sinalizada.
- Após correções, pipeline voltou a estado saudável.

## Roteiro de explicação em aula (curto)

- 5 min: contexto DevSecOps e pipeline única.
- 10 min: baseline da pipeline.
- 20 min: 3 exercícios de falha em PR.
- 10 min: correção e fechamento.

## Dicas para manter didático

- Evite muitos scanners ao mesmo tempo na primeira execução.
- Foque em evidência visual no PR/Actions.
- Use falhas intencionais e controladas.
- Sempre finalize com correção para reforçar aprendizado.
