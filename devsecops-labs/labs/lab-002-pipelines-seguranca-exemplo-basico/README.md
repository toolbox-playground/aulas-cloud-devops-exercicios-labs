# Lab 002 - Pipelines de Segurança: Exemplo Básico

## Objetivo

Explorar um exemplo básico de pipeline com etapas de segurança integradas, entendendo como ferramentas de análise estática, verificação de dependências e escaneamento de imagens podem ser orquestradas em um fluxo de CI/CD.

## Duração e dificuldade

- Duração estimada: 30 a 45 minutos
- Dificuldade: iniciante

## Repositório base

- https://github.com/toolbox-playground/pipelines-seguranca-exemplo-basico

## Contexto da prática

Você vai explorar um repositório de exemplo que demonstra como estruturar pipelines de segurança do zero. O foco é entender a anatomia de cada etapa de segurança no pipeline e como os resultados são apresentados.

## O que será praticado

- Leitura e entendimento da estrutura de um pipeline de segurança básico
- Identificação das ferramentas de segurança utilizadas em cada etapa
- Execução local das verificações de segurança
- Interpretação dos relatórios gerados pelo pipeline

## Fluxo recomendado do aluno

1. Faça fork do repositório base ou clone localmente:

```bash
git clone https://github.com/toolbox-playground/pipelines-seguranca-exemplo-basico
cd pipelines-seguranca-exemplo-basico
```

2. Explore a estrutura do projeto e leia o README do repositório.

3. Analise os arquivos de configuração do pipeline (`.github/workflows/`).

4. Identifique quais ferramentas de segurança são utilizadas e em quais etapas.

5. Execute o pipeline via PR ou branch no repositório forkado:

```bash
git checkout -b lab-002-seu-nome
git push -u origin lab-002-seu-nome
```

6. Abra um Pull Request e observe os checks de segurança sendo executados.

7. Leia os resultados de cada etapa do pipeline e documente os findings encontrados.

## Como demonstrar em aula (roteiro curto)

1. Mostrar a estrutura do repositório e explicar o pipeline.
2. Abrir o arquivo de workflow e percorrer cada etapa.
3. Criar uma branch, abrir um PR e mostrar a execução do pipeline ao vivo.
4. Interpretar os resultados de pelo menos uma ferramenta de segurança.

## Dicas práticas

- Leia o README do repositório base antes de começar.
- Preste atenção nos nomes dos jobs e na ordem de execução do pipeline.
- Compare com o Lab 001 para identificar semelhanças e diferenças de abordagem.
