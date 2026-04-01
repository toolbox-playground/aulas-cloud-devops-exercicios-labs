# Comandos essenciais do kubectl

Agora que você já tem um cluster rodando, vamos aprender os comandos que você vai usar no dia a dia.

Pense no **kubectl** como o equivalente ao **docker CLI**, mas para Kubernetes.

---

## 🔁 Comparação rápida: Docker vs Kubernetes

| Docker                | Kubernetes               | O que faz                          |
|----------------------|--------------------------|-----------------------------------|
| docker ps            | kubectl get pods         | Lista containers/pods             |
| docker logs          | kubectl logs             | Ver logs                          |
| docker exec          | kubectl exec             | Entrar no container               |
| docker rm            | kubectl delete           | Remove recurso                    |

---

## 📦 Listando recursos

### Ver Pods

```bash
kubectl get pods
```

Saída esperada:
```bash
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          10s
```

---

### Ver mais detalhes (wide)

```bash
kubectl get pods -o wide
```

Mostra:
- IP do Pod
- Node onde está rodando

---

### Ver outros recursos

```bash
kubectl get nodes
kubectl get services
kubectl get deployments
```

---

## 🔍 Inspecionando recursos

### Descrever um Pod

```bash
kubectl describe pod nginx
```

Mostra:
- eventos
- imagem
- erros
- status detalhado

💡 Esse é um dos comandos MAIS importantes para debug

---

## 📜 Logs

Ver logs de um Pod:

```bash
kubectl logs nginx
```

Seguir logs em tempo real:

```bash
kubectl logs -f nginx
```

---

## 🧠 Executando comandos dentro do Pod

```bash
kubectl exec -it nginx -- bash
```

Dentro do container, execute alguns comandos para verificar se você realmente está dentro do container, que roda um SO diferente do SO da sua máquina:

```bash
uname -a  # Informação do SO
whoami  # Usuário atual
ls -l  # Listar arquivos e pastas
exit
```

---

## ❌ Removendo recursos

```bash
kubectl delete pod nginx
```

---

## 📂 Trabalhando com namespaces

Ver namespaces:

```bash
kubectl get namespaces
```

Usar namespace específico:

```bash
kubectl get pods -n kube-system
```

---

## ⚡ Resumo rápido

| Comando                          | O que faz                  |
|----------------------------------|----------------------------|
| kubectl get pods                | Lista pods                 |
| kubectl describe pod <nome>     | Detalhes do pod            |
| kubectl logs <nome>             | Ver logs                   |
| kubectl exec -it <nome> -- bash | Entrar no container        |
| kubectl delete pod <nome>       | Remove pod                 |
| kubectl get nodes              | Lista nodes                |

---

## 🏆 Desafio extra

- Crie dois pods diferentes
- Veja os logs de ambos
- Descubra em qual node cada um está rodando

Dica:
```bash
kubectl get pods -o wide
```

---

## 💡 Reflexão

O que mudou em relação ao Docker?

- Você não gerencia containers diretamente
- Tudo passa pelo Kubernetes
- Os recursos são declarativos e controlados pelo cluster

---

## Próximo passo

No próximo capítulo você vai:

👉 Entender profundamente o que é um **Pod**  
👉 Ver como múltiplos containers funcionam juntos  
👉 Explorar o ciclo de vida de um Pod
