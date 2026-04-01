# Lab 003 - Agents de IA na prática via IDE com MCP

## Objetivo

Explorar agentes de IA com MCP para análise de código, execução de tarefas e integração com ferramentas externas.

## Dificuldade e tempo

- Dificuldade: Intermediário
- Tempo estimado: 45 a 70 minutos

## Propósito

Demonstrar o poder de agentes de IA integrados em IDEs com suporte a MCP, permitindo automatizar tarefas de desenvolvimento, criar integrações com ferramentas externas (Jira, Miro, GitHub) e executar fluxos complexos a partir de linguagem natural.

## Ferramentas sugeridas

- VS Code + Copilot
- Cursor IDE
- MCPs conectados (ex.: Jira, Miro, GitHub)

## Pré-requisitos

- VS Code: https://code.visualstudio.com/ ou Cursor: https://cursor.com/
- GitHub Copilot ativo (para VS Code) ou assinatura Cursor
- Conta no Jira (para MCP Jira): https://www.atlassian.com/software/jira
- Conta no Miro (para MCP Miro): https://miro.com/
- Conta no GitHub (para MCP GitHub): https://github.com/

## Referências do material

- VS Code Copilot: https://code.visualstudio.com/docs/copilot/overview
- MCP no VS Code: https://code.visualstudio.com/docs/copilot/chat/mcp-servers
- VS Code MCP: https://code.visualstudio.com/mcp
- Cursor: https://cursor.com/
- Cursor MCP Docs: https://docs.cursor.com/tools/mcp
- MCP Directory: https://cursor.directory/mcp

## Passo a passo

1. Configure uma IDE agentic (VS Code Copilot ou Cursor).
2. Configure servidores MCP que desejar usar (Jira, Miro, GitHub).
3. Abra o chat do agente na IDE.
4. Execute os prompts abaixo em sequência.
5. Valide as saídas em cada etapa (análise, execução, task, diagrama e PR).

## Regra obrigatória para todos os prompts

Sempre inclua no final de cada prompt:

```text
Ao concluir, retorne as evidências em formato objetivo: ID e link do ticket Jira (se aplicável), link do board/diagrama no Miro (se aplicável), link do PR (se aplicável), e um resumo curto do que foi feito.
```

## Prompts do lab (copiar e colar)

### Prompt 1

```text
Analise o código fonte dessa repositório que encontrei na internet e me explique do que se trata, arquitetura e estrutura do repo > https://github.com/toolbox-playground/hello-world-com-docker-languages
```

### Prompt 2

```text
Estou realizando exercícios de docker e python para reforçar conceitos de devops e cloud e encontrei este repo no github que acabei de te enviar com alguns exercícios. Me ajude a baixar o repo e executar o exercício de python.
```

### Prompt 3

```text
Agora que executamos o exercício, gostaria que você refizesse o exercício mas mude o container para uma imagem de container de jogo. Quero testar como executar localmente um jogo com docker e outro dia vi um cara rodando um jogo do supermario local em sua máquina usando docker, então creio que deve existir um container de supermario que dê para usar. Procure o container, baixe e execute para que eu consiga jogar local host.
```

### Prompt 4

```text
Crie uma task para mim no jira usando mcp jira para adicionar nesse exercicio hello world python uma tarefa de baixar a imagem do jogo do supermario com docker e executar o jogo como um lab extra mesmo e me de o link ou numero dessa tarefa no jira.
```

### Prompt 5

```text
Agora use o mcp de miro para criar uma arquitetura básica ou diagrama de fluxo que demonstra o funcionamento deste exercício que estou fazendo porque quero entender melhor os fluxos desse lab.
```

### Prompt 6

```text
Agora usando o mcp de github altere e inclua o que se pede nessa tarefa do jira no código e proponha um PR no projeto. Quero implementar essa tarefa logo e usar mcp para propor o pull request.
```

## Validação guiada

- O agente analisou o repositório e explicou arquitetura/estrutura.
- O agente executou ou guiou a execução do exercício Python.
- Foi criada task no Jira via MCP.
- Foi criado diagrama no Miro via MCP.
- Foi proposta alteração e PR via MCP GitHub.
- Cada etapa retornou evidências objetivas (ID/link do Jira, link do Miro, link do PR, quando aplicável).
