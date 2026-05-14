# Lab 004 - Dashboard de clima em tempo real com Grafana e OpenWeatherMap

## Objetivo

Subir o Grafana via Docker, importar um dashboard de clima pré-construído com dados
de OpenWeatherMap e explorar os conceitos de painéis, variáveis e data sources no Grafana.

## Duração e dificuldade

- Duração estimada: 20 a 30 minutos (parte principal) + desafio opcional
- Dificuldade: intermediário

## Pré-requisitos

- Docker instalado
- Porta 3000 livre no computador

## Fluxo recomendado do aluno

### 1. Subir o Grafana

```bash
docker run -d -p 3000:3000 --name=grafana grafana/grafana
```

Verifique que o container está rodando:

```bash
docker ps
```

### 2. Acessar o Grafana

Abra o navegador em [http://localhost:3000](http://localhost:3000).

Login padrão: usuário **`admin`**, senha **`admin`**. Na primeira vez, o Grafana pede para trocar a senha — pode clicar em **Skip** para o lab.

### 3. Importar o dashboard Open Weather Map

1. No menu lateral, clique em **Dashboards > Import**.
2. No campo **Import via grafana.com**, digite o ID **`9710`** e clique em **Load**.
3. Clique em **Import** — o dashboard já vem com demo data embutida, nenhum data source externo é necessário agora.
4. Explore os painéis: temperatura, sensação térmica, umidade, velocidade do vento e condição do tempo.

### 4. Explorar os painéis

- Clique em qualquer painel e selecione **Edit** para ver como a query foi construída.
- Observe as **variáveis de template** do dashboard: menu **Dashboard settings > Variables**.
- Experimente alterar o intervalo de tempo no seletor no canto superior direito.

## Desafio: conectar dados reais

Quer ver o clima da sua cidade em tempo real? Aqui estão as dicas para ir além:

1. **Obter API Key gratuita** no [OpenWeatherMap](https://openweathermap.org/) (plano free, sem cartão de crédito).
2. **Subir o openweather-exporter** para converter a API OpenWeatherMap em métricas Prometheus:
   - Repositório: [billykwooten/openweather-exporter](https://github.com/billykwooten/openweather-exporter)
   - Configure `OW_CITY` (ex: `"Sao Paulo,BR"`) e `OW_APIKEY` via variáveis de ambiente.
3. **Instalar o Prometheus** e configurar para raspar as métricas do exporter.
4. **Adicionar o data source Prometheus** no Grafana e adaptar o dashboard para usar dados reais.
5. Referência completa: [How to monitor your local weather with Grafana](https://grafana.com/blog/how-to-monitor-your-local-weather-with-grafana/)

## Limpeza

```bash
docker stop grafana && docker rm grafana
```

## Referências

- [grafana/grafana - Docker Hub](https://hub.docker.com/r/grafana/grafana)
- [How to monitor your local weather with Grafana - Grafana Blog](https://grafana.com/blog/how-to-monitor-your-local-weather-with-grafana/)
- [Open Weather Map Dashboard (ID 9710) - Grafana Labs](https://grafana.com/grafana/dashboards/9710-open-weather-map/)
- [openweather-exporter - GitHub](https://github.com/billykwooten/openweather-exporter)
- [OpenWeatherMap Free API](https://openweathermap.org/api)
