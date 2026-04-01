# Entendendo Pods de verdade

Agora vamos entender o conceito mais importante do Kubernetes: **Pod**.

Se você entender bem isso, metade do Kubernetes fica fácil.

---

## 🧠 O que é um Pod?

Um **Pod** é a menor unidade executável no Kubernetes.

Ele representa **um ou mais containers rodando juntos** no mesmo ambiente.

👉 Na prática, você quase sempre usa **1 container por Pod**.

---

## 🆚 Container vs Pod

| Docker                | Kubernetes           |
|----------------------|---------------------|
| Container            | Pod                 |
| docker run           | kubectl run         |

💡 Importante:
> Kubernetes NÃO gerencia containers diretamente.  
> Ele gerencia **Pods**.

---

## 📦 O que existe dentro de um Pod?

Um Pod contém:

- 1 ou mais containers
- Rede compartilhada (mesmo IP)
- Volume compartilhado (opcional)

---

## Visão visual de um Pod

**[Desenho da estrutura do Pod:](https://kubernetes.io/pt-br/docs/tutorials/kubernetes-basics/explore/explore-intro/)**  

```mermaid
Node Kubernetes  
└─ Pod  
   ├─ IP compartilhado  
   ├─ Volume compartilhado  
   ├─ Container App  
   └─ Container Sidecar  
```

**Relacionamentos dentro do Pod:**  
```mermaid
IP compartilhado ──► Container App  
IP compartilhado ──► Container Sidecar  
Volume compartilhado ──► Container App  
Volume compartilhado ──► Container Sidecar
```

### Como ler esse diagrama

- O **Pod** vive dentro de um **Node**
- Dentro do Pod, os containers compartilham:
  - o mesmo **IP**
  - o mesmo **localhost**
  - volumes que forem montados
- Isso permite que dois containers cooperem como se estivessem muito próximos

👉 Exemplo comum:
- **Container principal** = aplicação
- **Sidecar** = logs, proxy, monitoramento

---

## 🌐 Rede dentro do Pod

Todos os containers dentro de um Pod:

- Compartilham o mesmo IP
- Se comunicam via `localhost`

👉 Isso permite padrões como:
- app + sidecar (ex: logger, proxy)

### Exemplo visual de comunicação

**Comunicação dentro do mesmo Pod:**  
Container App ◄── localhost ──► Container Sidecar  
Mesmo IP • mesma rede • mesmo contexto de comunicação

👉 Ou seja: os containers do mesmo Pod não precisam descobrir IPs diferentes entre si.

---

## 🔁 Ciclo de vida de um Pod

Estados mais comuns:

| Status            | Significado                          |
|------------------|--------------------------------------|
| Pending          | Criando o Pod                        |
| Running          | Rodando normalmente                  |
| Succeeded        | Finalizado com sucesso               |
| Failed           | Falhou                               |
| CrashLoopBackOff | Loop de falha                        |

### Fluxo visual do ciclo de vida

**Fluxo do ciclo de vida do Pod:**  
```chart
Pending  
└─► Running  
   ├─► Succeeded  
   ├─► Failed  
   └─► CrashLoopBackOff
```
---

## 🧪 Criando um Pod (imperativo)

```bash
kubectl run nginx --image=nginx
```

Verifique:

```bash
kubectl get pods
```

---

## 🔍 Explorando o Pod

Descreva:

```bash
kubectl describe pod nginx
```

Veja logs:

```bash
kubectl logs nginx
```

---

## ⚠️ Pods são efêmeros

Se um Pod morrer:

- Ele não é automaticamente recriado (nesse modelo simples)
- Você perde estado (sem volumes)

👉 Por isso, em produção usamos **Deployments**

### Visão simples do problema

**Problema do Pod isolado:**  
Pod em execução ──► Pod morreu ──► sem recuperação automática


---

## 💡 Reflexão

O que você aprendeu?

- Pod é a unidade básica do Kubernetes
- Containers vivem dentro de Pods
- Containers do mesmo Pod compartilham rede e podem compartilhar volume

---

## Próximo passo

No próximo capítulo você vai:

👉 Trabalhar com **YAML de forma mais profunda**  
👉 Criar recursos de forma declarativa  
👉 Entrar no mindset real de Kubernetes
