# Lab 004 - Dashboard de clima em tempo real com Grafana e OpenWeatherMap

## Objetivo

Explorar um dashboard de clima pré-construído no Grafana com dados de OpenWeatherMap.
O lab apresenta conceitos de dashboards Grafana (painéis, variáveis, data sources) e
termina com um desafio de conectar dados meteorológicos reais.

## Duração e dificuldade

- Duração estimada: 20 a 30 minutos (parte principal) + desafio opcional
- Dificuldade: intermediário

## Pré-requisitos

- Docker e Docker Compose instalados
- Porta 3000 livre no computador

## Fluxo recomendado do aluno

### 1. Subir o Grafana

```bash
# Na raiz deste diretório (onde está o docker-compose.yml)
docker compose up -d
```

Aguarde ~10 segundos e verifique:

```bash
docker compose ps
```

### 2. Acessar o Grafana

Abra o navegador em [http://localhost:3000](http://localhost:3000).
Login padrão: usuário `admin`, senha `admin`.

### 3. Importar o dashboard Open Weather Map

1. No menu lateral, clique em **Dashboards > Import**.
2. No campo **Import via grafana.com**, digite o ID `9710` e clique em **Load**.
3. Clique em **Import** (o dashboard usa demo data embutida, nenhum data source é necessário agora).
4. Explore os painéis: temperatura, sensação térmica, umidade, vento e condição do tempo.

### 4. Explorar os painéis

- Clique em um painel e selecione **Edit** para ver como a query foi construída.
- Observe como variáveis de template são usadas (menu **Dashboard settings > Variables**).
- Experimente alterar o tema do Grafana (ícone de usuário > **Preferences**).

## Desafio: conectar dados reais

Quer ver o clima da sua cidade em tempo real? Aqui estão as dicas para ir além:

1. **Obter API Key gratuita** no [OpenWeatherMap](https://openweathermap.org/) (plano free, sem cartão de crédito).
2. **Subir o openweather-exporter** (converte a API OpenWeatherMap em métricas Prometheus):
   - Repositório: [billykwooten/openweather-exporter](https://github.com/billykwooten/openweather-exporter)
   - Configure `OW_CITY` e `OW_APIKEY` via variáveis de ambiente.
3. **Adicionar Prometheus** como intermediário para raspar as métricas do exporter.
4. **Configurar o data source Prometheus** no Grafana e adaptar o dashboard para usar dados reais.
5. Referência completa: [How to monitor your local weather with Grafana](https://grafana.com/blog/how-to-monitor-your-local-weather-with-grafana/)

## Como demonstrar em aula (roteiro curto)

1. **[3 min]** Subir o Grafana e mostrar a interface.
2. **[5 min]** Importar o dashboard 9710 e explorar os painéis.
3. **[5 min]** Abrir o editor de um painel e mostrar a estrutura da query.
4. **[5 min]** Apresentar o desafio de dados reais e mostrar a arquitetura: API → exporter → Prometheus → Grafana.

## Limpeza

```bash
docker compose down -v
```

## Referências

- [How to monitor your local weather with Grafana - Grafana Blog](https://grafana.com/blog/how-to-monitor-your-local-weather-with-grafana/)
- [Open Weather Map Dashboard (ID 9710) - Grafana Labs](https://grafana.com/grafana/dashboards/9710-open-weather-map/)
- [openweather-exporter - GitHub](https://github.com/billykwooten/openweather-exporter)
- [OpenWeatherMap Free API](https://openweathermap.org/api)
