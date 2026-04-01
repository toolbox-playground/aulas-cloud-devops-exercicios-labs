# Deployments (rodando aplicações de verdade)

Até agora você trabalhou com Pods diretamente.

Mas na vida real, **você quase nunca usa Pods sozinhos em produção**.

👉 Você usa **Deployments**.

---

## 🧠 O problema dos Pods

Se um Pod morrer:

- Ele não é recriado automaticamente
- Você perde disponibilidade
- Não existe escalabilidade

👉 Isso não é aceitável em produção.

---

## 🚀 A solução: Deployment

Um **Deployment** é um recurso que:

- Garante que os Pods estejam sempre rodando
- Permite escalar (mais ou menos réplicas)
- Faz atualizações sem downtime

---

## 📦 Como funciona

Deployment → ReplicaSet → Pods

- **Deployment** define o estado desejado
- **ReplicaSet** garante o número de Pods
- **Pods** executam a aplicação

---

## 📄 Criando um Deployment (YAML)

Crie um arquivo `deployment.yaml`:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: nginx
          ports:
            - containerPort: 80
```

---

## 🚀 Aplicando o Deployment

```bash
kubectl apply -f deployment.yaml
```

Verifique:

```bash
kubectl get deployments
kubectl get pods
```

👉 Você verá múltiplos Pods rodando automaticamente

---

## 📈 Escalando a aplicação

```bash
kubectl scale deployment nginx-deployment --replicas=4
```

Verifique:

```bash
kubectl get pods
```

---

## 🔄 Atualizando a aplicação

Exemplo: mudar a imagem

```bash
kubectl set image deployment/nginx-deployment nginx=nginx:latest
```

Verifique rollout:

```bash
kubectl rollout status deployment nginx-deployment
```

---

## ⏪ Rollback

Se algo der errado:

```bash
kubectl rollout undo deployment nginx-deployment
```

---

## 🔍 Inspecionando

```bash
kubectl describe deployment nginx-deployment
```

---

## ❌ Removendo

```bash
kubectl delete -f deployment.yaml
```

---

## ⚡ Resumo

| Conceito     | Função                         |
|--------------|--------------------------------|
| Deployment   | Define estado desejado          |
| ReplicaSet   | Garante número de Pods          |
| Pod          | Executa container               |

---

## 🏆 Desafio extra

- Crie um Deployment com 3 réplicas
- Escale para 5
- Faça rollback após alterar imagem

---

## 💡 Reflexão

O que mudou?

- Agora você não gerencia Pods manualmente
- Kubernetes mantém tudo funcionando automaticamente
- Você entrou no modo “produção”

---

## Próximo passo

No próximo capítulo você vai:

👉 Expor aplicações com **Service**  
👉 Tornar seu app acessível externamente
