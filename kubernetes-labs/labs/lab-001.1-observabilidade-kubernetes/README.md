# Lab 001.1 — Observabilidade no Kubernetes: Prometheus, Grafana, Loki e Alertas

## Objetivo

Instalar o stack completo de observabilidade num cluster Kind e visualizar em tempo real
métricas, logs e alertas da aplicação do Lab 001 (Super Mario + HPA).

## Duração e dificuldade

- Duração estimada: 45 a 60 minutos
- Dificuldade: intermediário

## Pré-requisito obrigatório

**Lab 001 concluído** — o cluster Kind `k8s-essentials` com Super Mario e HPA devem estar rodando.
Verifique:

```bash
kubectl get pods -n games
kubectl get hpa -n games
```

Caso o cluster não exista mais, recrie-o seguindo o Lab 001 antes de continuar.

## Repositório base

- https://github.com/toolbox-playground/caio-k8s/tree/main/curso-k8s/modulo-03-monitoring

## Ferramentas adicionais necessárias

- `helm` — gerenciador de pacotes Kubernetes: https://helm.sh/docs/intro/install/

## O que será instalado

| Componente | Função |
|---|---|
| **Prometheus** | Coleta e armazena métricas do cluster |
| **Grafana** | Dashboards para métricas (Prometheus) e logs (Loki) |
| **Alertmanager** | Roteamento de alertas (Discord, Slack, e-mail) |
| **Loki** | Armazena logs indexados por labels do Kubernetes |
| **Fluent Bit** | DaemonSet que coleta logs de todos os pods e envia ao Loki |
| **Node Exporter** | Métricas do sistema operacional de cada node |
| **kube-state-metrics** | Estado dos objetos Kubernetes como métricas |

## Fluxo recomendado do aluno

### 1. Recriar o cluster com as portas de monitoramento mapeadas

O módulo 03 precisa de portas extras mapeadas (Prometheus :9090, Grafana :3000, Alertmanager :9093).
O `cluster-config.yaml` do módulo já inclui todos esses mapeamentos.

```bash
git clone https://github.com/toolbox-playground/caio-k8s.git
cd caio-k8s/curso-k8s/modulo-03-monitoring
```

```bash
# Recriar o cluster com os novos port mappings
kind delete cluster --name k8s-essentials
kind create cluster --config manifests/cluster-config.yaml

# Reinstalar o Metrics Server (necessário após recriar)
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl patch deployment metrics-server -n kube-system --type=json \
  -p='[{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--kubelet-insecure-tls"}]'

# Reinstalar o Super Mario (do módulo 02)
kubectl create namespace games
kubectl apply -f ../modulo-02-deploy-app/manifests/01-deployment-mario.yaml
kubectl apply -f ../modulo-02-deploy-app/manifests/02-service-mario.yaml
kubectl apply -f ../modulo-02-deploy-app/manifests/03-hpa.yaml
```

### 2. Instalar o kube-prometheus-stack (Prometheus + Grafana + Alertmanager)

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm install kind-prometheus prometheus-community/kube-prometheus-stack \
  --namespace monitoring --create-namespace \
  -f helm-values/values-prometheus-stack.yaml \
  --wait
```

Verifique os pods subindo:

```bash
kubectl get pods -n monitoring --watch
```

Acesse os serviços (em terminais separados ou em background):

```bash
kubectl port-forward svc/kind-prometheus-kube-prome-prometheus -n monitoring 9090:9090 &
kubectl port-forward svc/kind-prometheus-grafana -n monitoring 3000:80 &
kubectl port-forward svc/kind-prometheus-kube-prome-alertmanager -n monitoring 9093:9093 &
```

- **Prometheus:** http://localhost:9090
- **Grafana:** http://localhost:3000
- **Alertmanager:** http://localhost:9093

> **Senha do Grafana:** obtenha com:
> ```bash
> kubectl get secret -n monitoring kind-prometheus-grafana \
>   -o jsonpath='{.data.admin-password}' | base64 -d
> ```

### 3. Instalar o Loki

```bash
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

helm install loki grafana/loki \
  --namespace monitoring \
  -f helm-values/values-loki.yaml \
  --wait
```

### 4. Instalar o Fluent Bit (coleta de logs)

```bash
helm repo add fluent https://fluent.github.io/helm-charts
helm repo update

helm install fluent-bit fluent/fluent-bit \
  --namespace monitoring \
  -f helm-values/values-fluent-bit.yaml \
  --wait
```

Verifique que o Fluent Bit está rodando em todos os nodes (DaemonSet):

```bash
kubectl get pods -n monitoring -l app.kubernetes.io/name=fluent-bit
```

### 5. Aplicar os alertas dos Four Golden Signals

```bash
kubectl apply -f manifests/01-four-golden-signals.yaml
kubectl apply -f manifests/02-blackbox-probe.yaml
kubectl apply -f manifests/03-grafana-alert-rules.yaml
```

Verifique no Prometheus (**Status → Rules**) que os alertas foram carregados.

### 6. Explorar o Grafana

1. Abra http://localhost:3000 e faça login (`admin` + senha do passo 2).
2. Vá em **Dashboards → Browse → Kubernetes** e explore os dashboards pré-instalados.
3. Importe o dashboard da comunidade: **Dashboards → New → Import → ID `15661`** → selecione Prometheus → Import.
4. Vá em **Explore → Loki** e rode a query de logs do Super Mario:

```logql
{kubernetes_namespace_name="games", kubernetes_container_name="super-mario"}
```

### 7. Gerar carga e observar

Em outro terminal, aplique o stress test do módulo 02:

```bash
kubectl apply -f ../modulo-02-deploy-app/manifests/04-stress-test-fortio.yaml
```

Acompanhe no Grafana:
- CPU e memória dos pods subindo
- HPA escalando as réplicas
- Logs do Super Mario em tempo real no Loki
- Alertas `AltoCPUSuperMario` e `HPANoLimiteMaximo` entrando em **Firing** no Prometheus e no Alertmanager

### 8. Configurar alertas no Discord (opcional)

1. No Discord: **Config do canal → Integrações → Webhooks → Novo Webhook** — copie a URL.
2. No Grafana: **Alerting → Contact Points → + Add** → tipo Discord → cole a URL → Test → Save.
3. **Alerting → Notification Policies → Edit Default** → selecione o contact point Discord.
4. Aguarde ~5 min após o stress test e veja o alerta chegar no canal.

## Como demonstrar em aula (roteiro curto)

1. **[5 min]** Explicar os três pilares (métricas, logs, alertas) e a arquitetura do stack.
2. **[10 min]** Instalar o kube-prometheus-stack e mostrar Prometheus + Grafana no ar.
3. **[5 min]** Instalar Loki + Fluent Bit e mostrar logs do Super Mario no Grafana Explore.
4. **[10 min]** Gerar carga com o stress test e observar CPU/HPA/alertas subindo em tempo real.
5. **[5 min]** Mostrar o alerta chegando no Discord.

## Limpeza

```bash
helm uninstall kind-prometheus -n monitoring
helm uninstall loki -n monitoring
helm uninstall fluent-bit -n monitoring
kubectl delete namespace monitoring
kubectl delete namespace games
kind delete cluster --name k8s-essentials
```

## Referências

- README completo do módulo: https://github.com/toolbox-playground/caio-k8s/blob/main/curso-k8s/modulo-03-monitoring/README.md
- QUICK-START detalhado: https://github.com/toolbox-playground/caio-k8s/blob/main/curso-k8s/modulo-03-monitoring/QUICK-START.md
- kube-prometheus-stack: https://artifacthub.io/packages/helm/prometheus-community/kube-prometheus-stack
- Loki docs: https://grafana.com/docs/loki/latest/
- Fluent Bit para Kubernetes: https://docs.fluentbit.io/manual/installation/kubernetes
