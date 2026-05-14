# Lab 002 - Criar conta e instalar agente Datadog

## Objetivo

Criar uma conta gratuita no Datadog, instalar o agente de infraestrutura via Guided Install e
visualizar métricas de CPU, memória, disco e rede no Infrastructure List. Opcionalmente,
instrumentar uma aplicação demo com o agente Datadog ou OpenTelemetry.

## Duração e dificuldade

- Duração estimada: 30 a 45 minutos
- Dificuldade: iniciante

## Pré-requisitos

- Acesso de administrador no seu computador
- Sistema operacional Linux, macOS ou Windows
- Git e Docker instalados
- Uma linguagem instalada (.NET, Java, JDK, Go ou Python) — necessária apenas para etapa opcional

## Fluxo recomendado do aluno

### 1. Criação de conta

1. Acesse [datadoghq.com](https://www.datadoghq.com) e clique em **Get Started Free**.
2. Preencha nome, e-mail e senha. Nenhum cartão de crédito é necessário.
3. O trial dura **14 dias** com acesso completo à plataforma.
4. Ao entrar, explore brevemente o menu lateral para se familiarizar com a interface.

### 2. Instalação do agente via Guided Install

O Guided Install já inclui sua API key pré-preenchida no comando gerado.

1. No menu lateral, vá em **Integrations > Agent**.
2. Selecione seu sistema operacional (Linux, macOS ou Windows).
3. Copie o comando gerado e execute no terminal:

```bash
# Exemplo macOS — o comando real é gerado pela UI com sua chave
DD_API_KEY=<SUA_API_KEY> DD_SITE="datadoghq.com" bash -c \
  "$(curl -L https://install.datadoghq.com/scripts/install_mac_os.sh)"
```

```bash
# Exemplo Linux — o comando real é gerado pela UI com sua chave
DD_API_KEY=<SUA_API_KEY> DD_SITE="datadoghq.com" bash -c \
  "$(curl -L https://install.datadoghq.com/scripts/install_script_agent7.sh)"
```

4. Após instalar, verifique o status do agente:

```bash
datadog-agent status
```

### 3. Obtenção e salvamento da API Key

1. No menu lateral, vá em **Organization Settings > API Keys**.
2. Copie sua API Key e salve em local seguro.
3. Consulte a [documentação oficial](https://docs.datadoghq.com/account_management/api-app-keys/) para mais detalhes.

### 4. Visualização de métricas de infraestrutura

1. Navegue até **Infrastructure > Infrastructure List** no menu lateral.
2. Seu host deve aparecer em até 2 minutos após a instalação.
3. Clique no host para ver o dashboard com CPU, memória, disco e rede atualizados a cada ~15 segundos.
4. Explore também **Metrics > Explorer** para consultar métricas individuais como `system.cpu.user`.

### 5. Instrumentação de aplicação demo (exercício adicional)

O Datadog oferece três formas de instrumentar uma aplicação:

- **Auto-instrumentação**: sem modificar o código, via variáveis de ambiente.
- **Instrumentação manual**: adicionando o SDK do Datadog ao código.
- **OpenTelemetry**: usando o SDK padrão da CNCF com exporter para Datadog.

Consulte a [documentação de instrumentação](https://docs.datadoghq.com/tracing/trace_collection/) e escolha uma das
[aplicações de demonstração](https://github.com/DataDog/dd-trace-demo-app) em Python, Java, PHP ou Go.
Siga o README dentro do diretório da linguagem escolhida.

## Como demonstrar em aula (roteiro curto)

1. **[5 min]** Mostrar criação de conta e tela inicial do Datadog.
2. **[10 min]** Executar o Guided Install ao vivo no terminal.
3. **[5 min]** Verificar com `datadog-agent status` que o agente está coletando dados.
4. **[10 min]** Navegar pelo Infrastructure List e explorar métricas do host.
5. **[opcional]** Instrumentar o app demo Python e mostrar traces no APM.

## Limpeza

```bash
# macOS
launchctl unload -w /Library/LaunchDaemons/com.datadoghq.agent.plist
sudo rm -rf /opt/datadog-agent

# Linux (systemd)
sudo systemctl stop datadog-agent
sudo apt-get remove datadog-agent     # Debian/Ubuntu
# ou
sudo yum remove datadog-agent         # RHEL/CentOS
```

## Referências

- [Getting Started with the Datadog Agent](https://docs.datadoghq.com/getting_started/agent/)
- [Install the Datadog Agent](https://www.datadoghq.com/install-datadog-agent/)
- [Datadog APM & Tracing](https://docs.datadoghq.com/tracing/)
