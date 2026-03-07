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
2. Stage `security-summary` + `python-ci` (em paralelo)
   - resumo consolidado + validações de CI
3. Stage `fake-cd`
   - simulação de deploy para ilustrar o CD sem deploy real

> Visualmente, a execução fica em 3 blocos: segurança -> ci/report -> cd.

## Fluxo obrigatório para cada exercício (aluno)

Repita este fluxo em **cada** exercício (passos 3, 4 e 5):

1. Crie uma branch de correção:

```bash
git checkout -b fix/lab001-<tema>
```

2. Faça somente as alterações do exercício.
3. Commit:

```bash
git add .
git commit -m "fix(lab-001): <resumo-da-correcao>"
```

4. Push da branch:

```bash
git push -u origin fix/lab001-<tema>
```

5. Abra PR para `main`.
6. Aguarde a pipeline rodar e valide no `Summary`:
   - se o erro foi corrigido, os achados daquele item devem reduzir/desaparecer.

## Mapa real de arquivos vulneráveis no repositório `caio-sec`

- Dependências vulneráveis: `examples/python/requirements.txt` (linhas 15 a 37)
- Segredos hardcoded: `examples/python/app.py` (linhas 26 a 31)
- SQL Injection: `examples/python/app.py` (linha 76)

> Esses pontos já existem no repositório original e são ideais para exercício de correção.

## Passo a passo de correção (exercício completo)

### Exercício A - Corrigir dependências vulneráveis

**Objetivo:** reduzir findings de dependências (Trivy/Snyk).

1. Na sua branch de correção, edite `examples/python/requirements.txt`.
2. Atualize as versões vulneráveis para versões seguras mínimas:

```text
flask>=3.0.0
requests>=2.31.0
pycryptodome>=3.19.0
sqlalchemy>=2.0.0
Werkzeug>=3.0.0
Jinja2>=3.1.3
cryptography>=42.0.0
```

3. Commit + push + PR.
4. Validação esperada no PR:
   - queda significativa em `Trivy` (vulnerabilidades de pacotes)
   - `Snyk` (quando habilitado) com redução de issues.

### Exercício B - Corrigir segredos hardcoded

**Objetivo:** remover findings de segredos (Gitleaks/TruffleHog).

1. Na sua branch, edite `examples/python/app.py` (linhas 26 a 31).
2. Substitua segredos hardcoded por variáveis de ambiente.

Trecho atual (vulnerável):

```python
SECRET_KEY = "example_secret_key_redacted"
API_KEY = "example_api_key_redacted"
DATABASE_PASSWORD = "example_db_password_redacted"
AWS_ACCESS_KEY = "example_aws_access_key_redacted"
AWS_SECRET_KEY = "example_aws_secret_key_redacted"
STRIPE_KEY = "example_stripe_key_redacted"
```

Exemplo de correção didática:

```python
SECRET_KEY = os.getenv("SECRET_KEY", "change-me-in-dev")
API_KEY = os.getenv("API_KEY", "")
DATABASE_PASSWORD = os.getenv("DATABASE_PASSWORD", "")
AWS_ACCESS_KEY = os.getenv("AWS_ACCESS_KEY", "")
AWS_SECRET_KEY = os.getenv("AWS_SECRET_KEY", "")
STRIPE_KEY = os.getenv("STRIPE_KEY", "")
```

3. Commit + push + PR.
4. Validação esperada no PR:
   - `Gitleaks` e `TruffleHog` com menos achados ou sem novos segredos.

### Exercício C - Corrigir SQL Injection

**Objetivo:** remover padrão inseguro de query dinâmica.

1. Na sua branch, edite `examples/python/app.py` (linha 76).
2. Troque query com f-string por query parametrizada.

Trecho atual (vulnerável):

```python
query = f"SELECT * FROM users WHERE username='{username}' AND password='{password}'"
cursor.execute(query)
```

Exemplo de correção:

```python
query = "SELECT * FROM users WHERE username = ? AND password = ?"
cursor.execute(query, (username, password))
```

3. Commit + push + PR.
4. Validação esperada no PR:
   - redução de alertas SAST/code scanning relacionados a injeção.

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

### Passo 3 - Rodar Exercício A (Dependências)

Siga o exercício completo “Exercício A - Corrigir dependências vulneráveis”.

Perguntas para os alunos:

- Quais pacotes eram os mais críticos?
- Quanto a quantidade total de findings reduziu após o PR?

### Passo 4 - Rodar Exercício B (Segredos)

Siga o exercício completo “Exercício B - Corrigir segredos hardcoded”.

Perguntas para os alunos:

- Em qual arquivo/linha estavam os segredos?
- Quais scanners acusaram os secrets (Gitleaks, TruffleHog)?

### Passo 5 - Rodar Exercício C (SQL Injection)

Siga o exercício completo “Exercício C - Corrigir SQL Injection”.

Perguntas para os alunos:

- Por que query parametrizada reduz risco de injeção?
- Qual alerta de segurança sumiu/reduziu após o ajuste?

### Passo 6 - Fechamento e comparação de resultados

1. Compare o `Summary` antes e depois dos PRs de correção.
2. Registre redução de findings por ferramenta.
3. Faça merge apenas quando os objetivos didáticos forem atingidos.

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