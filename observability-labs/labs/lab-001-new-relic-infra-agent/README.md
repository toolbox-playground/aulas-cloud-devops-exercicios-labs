# Lab 001 - Criar conta e navegar no New Relic

## Objetivo

Criar uma conta gratuita no New Relic, instalar o agente de infraestrutura via Guided Install e
visualizar métricas básicas do host (CPU, memória, disco e rede) no dashboard de Infrastructure.

## Duração e dificuldade

- Duração estimada: 30 a 45 minutos
- Dificuldade: iniciante

## Pré-requisitos

- Acesso de administrador no seu computador
- Sistema operacional Linux, macOS ou Windows
- Git e Docker instalados
- Uma linguagem instalada (.NET, Java, JDK, Go ou Python) — necessária apenas para a etapa opcional de app demo

## Fluxo recomendado do aluno

### 1. Criação de conta

1. Acesse [newrelic.com](https://newrelic.com) e clique em **Sign up for free**.
2. Preencha nome, e-mail e senha. Nenhum cartão de crédito é necessário.
3. O plano free inclui **100 GB/mês de ingestão de dados** e um usuário com acesso completo.
4. Ao entrar na plataforma, explore brevemente o menu lateral para se familiarizar com a interface.

### 2. Navegação e aprendizado (opcional)

- Explore os vídeos de demonstração disponíveis na [plataforma online do New Relic](https://learn.newrelic.com/).

### 3. Instalação do agente via Guided Install

O Guided Install cuida de toda a configuração automaticamente: gera a chave de licença, detecta o sistema operacional e configura o agente.

1. No menu lateral, clique em **+ Add data** (ou **Add more data**).
2. Selecione **Guided install**.
3. Escolha seu sistema operacional (Linux, macOS ou Windows).
4. Copie o comando gerado (já contém sua licença pré-preenchida) e execute no terminal:

```bash
# Exemplo Linux/macOS — o comando real é gerado pela UI com sua chave
curl -Ls https://download.newrelic.com/install/newrelic-cli/scripts/install.sh | bash && \
  sudo NEW_RELIC_API_KEY=<SUA_CHAVE> NEW_RELIC_ACCOUNT_ID=<SEU_ID> \
  /usr/local/bin/newrelic install
```

5. Siga as instruções interativas. O installer detecta automaticamente o ambiente.
6. Ao finalizar, clique no link exibido no terminal ou volte à UI e vá em **Infrastructure > Hosts**.

### 4. Visualização de métricas

1. Navegue até **Infrastructure > Hosts** no menu lateral.
2. Clique no seu host para abrir o dashboard de detalhes.
3. Explore as abas: **Summary** (CPU, memória, disco), **Network**, **Processes**.
4. Use o seletor de tempo no canto superior direito para ajustar a janela de visualização.

### 5. Execução de app demo com OpenTelemetry (exercício adicional)

- Siga o [tutorial OpenTelemetry para Python](https://docs.newrelic.com/docs/more-integrations/open-source-telemetry-integrations/opentelemetry/get-started/opentelemetry-tutorial-python/) para baixar, instrumentar e executar um app de demonstração.
- Ou escolha uma das [aplicações de demonstração](https://github.com/newrelic/newrelic-opentelemetry-examples) em .NET, Python, Java ou Go e siga os passos no README de cada diretório `instrumented` ou `uninstrumented`.

## Como demonstrar em aula (roteiro curto)

1. **[5 min]** Mostrar a criação de conta e a tela inicial do New Relic.
2. **[10 min]** Executar o Guided Install ao vivo no terminal e aguardar o agente se conectar.
3. **[10 min]** Navegar pelo dashboard de Hosts: CPU, memória, processos em tempo real.
4. **[opcional]** Executar o app demo Python com OpenTelemetry e mostrar traces/métricas na UI.

## Limpeza

Para remover o agente de infraestrutura após o lab:

```bash
# Linux (systemd)
sudo systemctl stop newrelic-infra
sudo apt-get remove newrelic-infra      # Debian/Ubuntu
# ou
sudo yum remove newrelic-infra          # RHEL/CentOS
```

## Referências

- [New Relic Guided Install](https://docs.newrelic.com/docs/infrastructure/infrastructure-agent/new-relic-guided-install-overview/)
- [New Relic OpenTelemetry Examples](https://github.com/newrelic/newrelic-opentelemetry-examples)
- [New Relic Learn](https://learn.newrelic.com/)
