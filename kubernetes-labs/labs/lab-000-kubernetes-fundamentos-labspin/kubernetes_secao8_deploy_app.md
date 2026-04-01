# Deploy de aplicação real (Docker → Kubernetes)

Agora vamos conectar tudo que você aprendeu até aqui 🔥

👉 Docker + Kubernetes + aplicação real

---

## 🧠 O objetivo

Você vai:

- Usar uma imagem Docker real
- Criar um Deployment
- Criar um Service
- Acessar a aplicação no navegador

---

## 📦 A aplicação

Vamos usar uma imagem simples de aplicação web:

```bash
nginxdemos/hello
```

Essa imagem retorna informações do servidor — ótima para testes.

---

## 📄 Criando o Deployment

Crie um arquivo `app-deployment.yaml`:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hello-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: hello
  template:
    metadata:
      labels:
        app: hello
    spec:
      containers:
        - name: hello
          image: nginxdemos/hello
          ports:
            - containerPort: 80
```

---

## 🚀 Aplicando o Deployment

```bash
kubectl apply -f app-deployment.yaml
```

Verifique:

```bash
kubectl get pods
kubectl get deployments
```

---

## 📄 Criando o Service

Crie um arquivo `app-service.yaml`:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: hello-service
spec:
  type: NodePort
  selector:
    app: hello
  ports:
    - port: 80
      targetPort: 80
      nodePort: 30008
```

---

## 🚀 Aplicando o Service

```bash
kubectl apply -f app-service.yaml
```

Verifique:

```bash
kubectl get services
```

---

## 🌐 Acessando a aplicação

Abra no navegador:

```bash
http://localhost:30008
```

👉 Você verá uma página com informações do container

---

## ⚖️ Testando o load balancing

Atualize a página várias vezes.

Como você tem múltiplos Pods:

```bash
kubectl get pods -o wide
```

👉 O Kubernetes distribui as requisições entre eles

---

## 📈 Escalando

```bash
kubectl scale deployment hello-app --replicas=4
```

Veja novamente:

```bash
kubectl get pods
```

---

## 🔄 Atualizando versão

```bash
kubectl set image deployment/hello-app hello=nginxdemos/hello:latest
```

---

## ❌ Limpeza

```bash
kubectl delete -f app-deployment.yaml
kubectl delete -f app-service.yaml
```

---

## 🏆 Desafio extra

- Use outra imagem Docker (ex: httpd ou node app)
- Mude a porta externa
- Escale para 5 pods

---

## 💡 Reflexão

O que você fez aqui?

- Pegou uma imagem Docker pronta
- Rodou no Kubernetes
- Expôs via Service
- Escalou horizontalmente

👉 Você fez um deploy real em Kubernetes

---

## Próximo passo

No próximo capítulo você vai:

👉 Aprender debugging real  
👉 Resolver erros comuns no Kubernetes
