# Debug e Troubleshooting no Kubernetes

Agora você vai aprender uma das habilidades mais importantes em DevOps:

👉 **descobrir e resolver problemas no Kubernetes**

---

## 🧠 O cenário real

Nem sempre tudo funciona de primeira.

Você pode encontrar erros como:

- Pod não inicia
- Container fica reiniciando
- Imagem não é encontrada
- Aplicação não responde

👉 Saber debugar é o que diferencia um iniciante de um profissional.

---

## 🔍 O fluxo de debug (regra de ouro)

Sempre siga essa ordem:

```bash
kubectl get pods
kubectl describe pod <nome>
kubectl logs <nome>
```

👉 90% dos problemas são resolvidos com isso

---

## ❌ Problema 1 — Pod não sobe (ImagePullBackOff)

Crie um Pod com imagem inválida:

```bash
kubectl run erro --image=nginx:errado
```

Verifique:

```bash
kubectl get pods
```

Você verá:
```bash
ImagePullBackOff
```

Agora investigue:

```bash
kubectl describe pod erro
```

👉 Procure por mensagens como:
- Failed to pull image
- repository not found

---

## 🔁 Problema 2 — CrashLoopBackOff

Quando o container inicia e falha repetidamente.

Exemplo:

```bash
kubectl run crash --image=busybox -- sleep 1
```

Verifique:

```bash
kubectl get pods
```

Status:
```bash
CrashLoopBackOff
```

Veja logs:

```bash
kubectl logs crash
```

👉 O processo está finalizando rápido demais

---

## 📜 Logs são seus melhores amigos

```bash
kubectl logs <nome>
kubectl logs -f <nome>
```

Se tiver múltiplos containers:

```bash
kubectl logs <pod> -c <container>
```

---

## 🔍 Describe: o comando mais importante

```bash
kubectl describe pod <nome>
```

Aqui você encontra:

- Eventos
- Erros de imagem
- Problemas de scheduling
- Falhas de rede

👉 Sempre olhe a seção **Events** no final

---

## 🌐 Problema 3 — Aplicação não responde

Checklist:

1. Pod está rodando?
```bash
kubectl get pods
```

2. Service existe?
```bash
kubectl get services
```

3. Labels batem?
```bash
kubectl describe service <nome>
```

👉 O selector precisa casar com os Pods

---

## 🔗 Verificando labels

```bash
kubectl get pods --show-labels
```

👉 Labels erradas = Service não funciona

---

## 🧠 Problema 4 — Porta errada

- containerPort errado
- targetPort errado
- nodePort errado

👉 Tudo precisa estar alinhado

---

## 🛠️ Exec para debug interno

```bash
kubectl exec -it <pod> -- sh
```

Dentro do container você pode:

```bash
curl localhost
ls
ps
```

---

## ⚡ Resumo de debug

| Comando                      | Uso principal              |
|-----------------------------|---------------------------|
| kubectl get pods           | Ver status geral          |
| kubectl describe pod       | Ver detalhes e erros      |
| kubectl logs               | Ver logs da aplicação     |
| kubectl exec               | Entrar no container       |

---

## 🏆 Desafio prático

1. Crie um Pod com imagem errada
2. Descubra o erro com describe
3. Corrija o problema
4. Suba corretamente

---

## 💡 Reflexão

O que você aprendeu?

- Debug no Kubernetes é investigativo
- Logs + describe resolvem quase tudo
- Saber diagnosticar é mais importante que decorar comandos

---

## Próximo passo

No próximo capítulo você vai:

👉 Limpar o cluster corretamente  
👉 Aprender boas práticas  
👉 Fechar o ciclo do laboratório
