# Lab 003 - Observabilidade local com OpenTelemetry e Grafana (Docker)

## Objetivo

Subir um ambiente local de observabilidade usando Docker Compose com o Grafana LGTM
(all-in-one: Grafana + Loki + Mimir + Tempo) e um OpenTelemetry Collector configurado
para coletar métricas de host (CPU, memória, disco, rede) e enviá-las ao Grafana.

## Duração e dificuldade

- Duração estimada: 30 a 40 minutos
- Dificuldade: iniciante a intermediário

## Pré-requisitos

- Docker e Docker Compose instalados
- Portas 3000, 4317 e 4318 livres no computador

## Repositório base

Os arquivos `docker-compose.yml` e `otel-collector-config.yaml` já estão neste diretório —
não é necessário clonar nenhum repositório adicional.

## Fluxo recomendado do aluno

### 1. Subir o ambiente

```bash
# Na raiz deste diretório (onde estão o docker-compose.yml e o otel-collector-config.yaml)
docker compose up -d
```

Aguarde ~15 segundos para os containers inicializarem. Verifique se estão rodando:

```bash
docker compose ps
```

### 2. Acessar o Grafana

1. Abra o navegador em [http://localhost:3000](http://localhost:3000).
2. Login: usuário `admin`, senha `admin` (ou entre sem senha se o acesso anônimo estiver ativo).
3. Explore o menu lateral.

### 3. Visualizar métricas de host

1. No menu lateral, clique em **Explore**.
2. Selecione o data source **Mimir** (ou **Prometheus**).
3. No campo de query, experimente:
   - `system_cpu_time_total` — tempo total de CPU
   - `system_memory_usage` — uso de memória
   - `system_disk_io` — I/O de disco
4. Clique em **Run query** e veja os dados em tempo real.

### 4. Importar dashboard de Host Metrics

1. No menu lateral, clique em **Dashboards > Import**.
2. Digite o ID `24638` e clique em **Load**.
3. Selecione o data source **Mimir** e clique em **Import**.
4. Explore o dashboard com painéis de CPU, memória, disco e rede.

## Como demonstrar em aula (roteiro curto)

1. **[3 min]** Explicar a stack: OTel Collector → Mimir (Prometheus-compat) → Grafana.
2. **[5 min]** Executar `docker compose up -d` e mostrar os containers subindo.
3. **[10 min]** Abrir o Grafana, importar o dashboard 24638 e explorar as métricas ao vivo.
4. **[5 min]** Abrir o `otel-collector-config.yaml` e explicar o pipeline: receiver → exporter.

## Limpeza

```bash
docker compose down -v
```

## Referências

- [Grafana Docker LGTM - Docs](https://grafana.com/docs/opentelemetry/docker-lgtm/)
- [grafana/docker-otel-lgtm - GitHub](https://github.com/grafana/docker-otel-lgtm)
- [Host Metrics Dashboard (ID 24638) - Grafana Labs](https://grafana.com/grafana/dashboards/24638-host-metrics/)
- [OpenTelemetry hostmetricsreceiver](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/receiver/hostmetricsreceiver)
