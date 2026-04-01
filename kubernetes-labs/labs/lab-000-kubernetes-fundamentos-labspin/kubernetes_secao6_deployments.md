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
          command: ["/bin/sh", "-c"]
          args:
            - |
              cat <<'EOF' > /usr/share/nginx/html/index.html
              <!doctype html>
              <html>
                <head>
                  <meta charset="utf-8" />
                  <title>Hello Kubernetes Deployment</title>
                </head>
                <body>
                  <h1>Hello Kubernetes! Eu sou um deployment.</h1>
                  <p>Se você deletar uma das pods, minha página web ainda continua de pé.</p>
                </body>
              </html>
              EOF
              nginx -g 'daemon off;'
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

Para validar no navegador (sem Service ainda):

```bash
kubectl port-forward --address 0.0.0.0 deployment/nginx-deployment <SUA_PORTA>:80
```

Abra no navegador:

> Adquira o IP da sua máquina: acesse a aba "Informações do lab" para pegar IP e abra no seu navegador:
```html
http://<IP_DA_MAQUINA>:<SUA_PORTA>

exemplo: http://20.127.19.164:<SUA_PORTA>/
```

👉 Você deverá ver a página customizada do Deployment.

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

## 🧪 Teste de resiliência 1 (deletando 1 Pod)

Neste teste, você vai derrubar apenas uma Pod e confirmar que o Deployment mantém a aplicação no ar.

```bash
kubectl get pods -l app=nginx
kubectl delete pod $(kubectl get pods -l app=nginx -o jsonpath='{.items[0].metadata.name}')
kubectl get pods -l app=nginx
kubectl get deployments
kubectl port-forward --address 0.0.0.0 deployment/nginx-deployment <SUA_PORTA>:80
```

Abra no navegador:

```html
http://<IP_DA_MAQUINA>:<SUA_PORTA>
```

👉 A página continua acessível porque as outras réplicas seguem ativas e o Kubernetes repõe a Pod removida.

---

## 🧪 Teste de resiliência 2 (deletando todas as Pods)

Agora derrube todas as Pods do Deployment e observe a recuperação automática.

```bash
kubectl get pods -l app=nginx
kubectl delete pods -l app=nginx
kubectl get pods -l app=nginx -w
kubectl get deployments
kubectl port-forward --address 0.0.0.0 deployment/nginx-deployment <SUA_PORTA>:80
```

Abra no navegador:

```html
http://<IP_DA_MAQUINA>:<SUA_PORTA>
```

👉 A página pode cair por alguns segundos, mas o Kubernetes recria as Pods sozinho e o acesso volta.

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
