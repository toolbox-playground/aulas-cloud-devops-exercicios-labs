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
2. Selecione o data source **Prometheus** (é o único data source de métricas disponível nesta
   stack — a imagem `grafana/otel-lgtm` não inclui Mimir).
3. No campo de query, experimente:
   - `system_cpu_time_seconds_total` — tempo total de CPU
   - `system_memory_usage_bytes` — uso de memória
   - `system_disk_io_bytes_total` — I/O de disco

   > Os nomes de métrica seguem a convenção de unidades do OpenTelemetry (sufixo `_seconds_total`,
   > `_bytes`, etc.). Se não aparecer nada, confira os nomes disponíveis em
   > **Explore > Metric** (autocomplete) ou consultando `/api/v1/label/__name__/values` no
   > Prometheus.
4. Clique em **Run query** e veja os dados em tempo real.

### 3.1 Mais exemplos de métricas (gauges vs. counters)

Nem toda métrica se comporta igual no Explore. Repare na diferença:

**Gauges** (valor atual, plotam direto sem transformação):

- `system_cpu_load_average_1m` — carga média de CPU no último minuto
- `system_cpu_logical_count` — número de CPUs lógicas
- `system_memory_usage_bytes{state="used"}` — memória em uso
- `system_network_connections{protocol="tcp"}` — conexões TCP por estado
- `system_disk_pending_operations` — operações de disco pendentes

**Counters** (`_total`, sempre crescentes — se plotar o nome puro o gráfico fica uma linha
subindo sem parar; use `rate(...[5m])` para ver a *taxa* de variação, que é o que
normalmente importa):

- `rate(system_cpu_time_seconds_total[5m])` — % de tempo de CPU usado por estado (user/system/idle)
- `rate(system_disk_io_bytes_total[5m])` — taxa de I/O de disco (bytes/s), filtre por `direction="read"` ou `"write"`
- `rate(system_network_io_bytes_total[5m])` — taxa de tráfego de rede (bytes/s)
- `rate(system_disk_operations_total[5m])` — operações de disco por segundo

> **Dica:** se uma query com `_total` aparecer "achatada" ou vazia mesmo com dados no
> Prometheus, o problema costuma ser justamente esse — falta o `rate()`.

### 4. Importar dashboard de Host Metrics

1. No menu lateral, clique em **Dashboards > Import**.
2. Digite o ID `24638` e clique em **Load**.
3. Selecione o data source **Prometheus** e clique em **Import**.
4. Explore o dashboard com painéis de CPU, memória, disco e rede.

> **Nota:** os dashboards "JVM Overview (OpenTelemetry)" e "RED Metrics" que já vêm criados
> por padrão na stack são exemplos para métricas de aplicação (JVM, HTTP) — não têm relação
> com este lab, que coleta apenas métricas de host. É esperado que fiquem sem dados, já que
> nenhuma aplicação instrumentada está rodando.

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
