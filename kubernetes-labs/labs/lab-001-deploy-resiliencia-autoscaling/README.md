# Lab 001 - Deploy, Resiliência e Autoscaling no Kubernetes

## Objetivo

Subir um app web no Kubernetes e demonstrar, ao vivo, dois comportamentos-chave:
**auto-healing** (pod cai e o app continua) e **auto-scaling** (mais carga, mais pods).

## Duração e dificuldade

- Duração estimada: 35 a 45 minutos
- Dificuldade: iniciante a intermediário

## Repositório base

- https://github.com/toolbox-playground/caio-k8s/tree/main/curso-k8s/modulo-02-deploy-app

## Pré-requisitos

- Docker Desktop (ou Docker Engine) rodando
- `kind`
- `kubectl`

Se você não tiver ambiente Kubernetes local, siga a documentação do Kind: https://kind.sigs.k8s.io/docs/user/quick-start/

## Fluxo recomendado do aluno

1. Clone o repositório base e entre no módulo:

```bash
git clone https://github.com/toolbox-playground/caio-k8s.git
cd caio-k8s/curso-k8s/modulo-02-deploy-app
```

2. Suba o cluster local:

```bash
kind create cluster --config manifests/cluster-config.yaml
kubectl create namespace games
```

3. Aplique o deploy + service + hpa:

```bash
kubectl apply -f manifests/01-deployment-mario.yaml
kubectl apply -f manifests/02-service-mario.yaml
kubectl apply -f manifests/03-hpa.yaml
kubectl get all -n games
```

4. Acesse a aplicação:

```bash
kubectl port-forward -n games service/super-mario-service 8081:8080
```

Abra no navegador: `http://localhost:8081`

5. Demonstre resiliência (auto-healing):

```bash
kubectl get pods -n games -l app=super-mario
kubectl delete pod $(kubectl get pods -n games -l app=super-mario -o jsonpath='{.items[0].metadata.name}') -n games
kubectl get pods -n games -l app=super-mario --watch
```

6. Demonstre autoscaling (HPA):

```bash
kubectl apply -f manifests/04-stress-test-fortio.yaml
kubectl get hpa -n games --watch
kubectl get pods -n games -l app=super-mario --watch
```

## Como demonstrar em aula (roteiro curto)

1. Mostrar app de pé no browser.
2. Matar 1 pod e provar recuperação automática.
3. Gerar carga e mostrar aumento de réplicas no HPA.
4. Encerrar mostrando estabilidade do app durante todo o processo.

## Limpeza

```bash
kubectl delete namespace games
kind delete cluster
```

## Referência

- README oficial completo: https://github.com/toolbox-playground/caio-k8s/blob/main/curso-k8s/modulo-02-deploy-app/README.md
