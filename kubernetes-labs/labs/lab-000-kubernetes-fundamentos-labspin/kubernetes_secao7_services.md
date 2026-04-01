# Services (expondo aplicações no Kubernetes)

Até agora você tem Pods e Deployments rodando…

Mas existe um problema:

👉 **Como acessar sua aplicação?**

---

## 🧠 O problema

Pods são:

- Efêmeros (podem morrer e nascer de novo)
- Têm IP dinâmico
- Não são acessíveis diretamente de fora

👉 Ou seja: você NÃO pode confiar no IP do Pod

---

## 🚀 A solução: Service

Um **Service** é uma camada de rede que:

- Dá um IP fixo para sua aplicação
- Faz balanceamento de carga entre Pods
- Permite acesso interno ou externo

---

## 📦 Como funciona

Service → seleciona Pods → distribui tráfego

Baseado em labels:

```yaml
labels:
  app: nginx
```

---

## 🔌 Tipos de Service

| Tipo        | Uso                                  |
|-------------|--------------------------------------|
| ClusterIP   | Acesso interno (default)             |
| NodePort    | Acesso externo via porta do node     |
| LoadBalancer| Cloud (AWS, GCP, Azure)              |

👉 No LabSpin, vamos usar **NodePort**

---

## 📄 Criando um Service (YAML)

Crie um arquivo `service.yaml`:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  type: NodePort
  selector:
    app: nginx
  ports:
    - port: 80
      targetPort: 80
      nodePort: 30007
```

---

## 🚀 Aplicando o Service

```bash
kubectl apply -f service.yaml
```

Verifique:

```bash
kubectl get services
```

---

## 🌐 Acessando a aplicação

Agora você pode acessar via:

```bash
http://localhost:30007
```

👉 O Service encaminha para os Pods automaticamente

---

## 🔍 Entendendo as portas

| Campo       | O que significa                      |
|-------------|-------------------------------------|
| port        | Porta do Service                    |
| targetPort  | Porta do container                  |
| nodePort    | Porta externa (host)                |

---

## ⚖️ Load Balancing automático

Se você tiver múltiplos Pods:

```bash
kubectl scale deployment nginx-deployment --replicas=3
```

O Service:

- Distribui requisições automaticamente
- Balanceia carga entre os Pods

---

## 🔍 Inspecionando

```bash
kubectl describe service nginx-service
```

---

## ❌ Removendo

```bash
kubectl delete -f service.yaml
```

---

## ⚡ Resumo

| Conceito   | Função                          |
|------------|---------------------------------|
| Service    | Expõe aplicação                 |
| Selector   | Liga Service aos Pods           |
| NodePort   | Permite acesso externo          |

---

## 🏆 Desafio extra

- Crie um Service para outro Deployment
- Acesse via porta diferente
- Escale o Deployment e observe o balanceamento

---

## 💡 Reflexão

O que você aprendeu?

- Pods não são acessíveis diretamente
- Services criam uma camada estável
- Kubernetes faz load balancing automaticamente

---

## Próximo passo

No próximo capítulo você vai:

👉 Fazer o deploy de uma aplicação real  
👉 Conectar Docker + Kubernetes na prática
