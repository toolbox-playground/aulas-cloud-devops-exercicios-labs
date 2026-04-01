# Limpeza e boas práticas no Kubernetes

Agora que você já criou vários recursos no cluster, é hora de aprender a:

👉 Manter o ambiente limpo  
👉 Evitar problemas futuros  
👉 Trabalhar como um profissional

---

## 🧠 O problema

Durante o aprendizado (ou até em produção), é comum:

- Criar vários Pods, Deployments e Services
- Esquecer recursos rodando
- Consumir recursos desnecessários

👉 Isso gera confusão e até custo em ambientes reais

---

## 🧹 Limpando recursos

### Remover um recurso específico

```bash
kubectl delete pod <nome>
kubectl delete deployment <nome>
kubectl delete service <nome>
```

---

### Remover via YAML

```bash
kubectl delete -f arquivo.yaml
```

👉 Melhor prática: sempre remover da mesma forma que criou

---

### Remover tudo de uma vez (cuidado ⚠️)

```bash
kubectl delete all --all
```

👉 Isso remove:
- Pods
- Deployments
- Services

---

## 🧼 Limpando por namespace

```bash
kubectl delete all --all -n default
```

---

## 🔍 Verificando o que ainda está rodando

```bash
kubectl get all
```

👉 Sempre faça isso antes de encerrar um laboratório

---

## 🧠 Boas práticas importantes

### 1. Use nomes claros

```bash
nginx-deployment
hello-service
```

👉 Evite nomes genéricos como `test`, `app1`

---

### 2. Use YAML sempre

- Versione no Git
- Evite comandos imperativos em produção

---

### 3. Use labels bem definidas

```yaml
labels:
  app: nginx
  env: dev
```

👉 Labels são a base do Kubernetes

---

### 4. Evite recursos soltos

❌ Pod sozinho  
✅ Deployment + Service

---

### 5. Limpe após uso

👉 Especialmente em ambientes de laboratório

---

## 🧪 Resetando o cluster (opcional)

Se quiser começar do zero:

```bash
kind delete cluster --name labspin
kind create cluster --name labspin
```

---

## ⚡ Checklist final

Antes de encerrar:

- [ ] Deletei todos os recursos?
- [ ] Testei todos os comandos?
- [ ] Entendi o fluxo completo?

---

## 🏆 Desafio final

- Crie um Deployment + Service
- Teste tudo
- Limpe completamente o cluster

---

## 💡 Reflexão

O que você aprendeu nesse módulo?

- Kubernetes não é só rodar container
- É sobre gerenciar, escalar e manter sistemas
- Organização e limpeza são fundamentais

---

## Próximo passo

Agora você está pronto para:

👉 Estudar Helm  
👉 Trabalhar com cloud (EKS, GKE, AKS)  
👉 Evoluir para nível intermediário 🚀
