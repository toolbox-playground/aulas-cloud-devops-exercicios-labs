# YAML no Kubernetes (modo declarativo)

Agora chegamos no ponto mais importante do Kubernetes: **trabalhar de forma declarativa com YAML**.

É aqui que muda completamente o jeito de pensar.

---

## 🧠 Imperativo vs Declarativo

### Imperativo (como fizemos até agora)

Você diz **como fazer**:

```bash
kubectl run nginx --image=nginx
```

👉 Você dá instruções diretas.

---

### Declarativo (jeito Kubernetes)

Você diz **o que quer**:

```yaml
kind: Pod
metadata:
  name: nginx
```

E o Kubernetes cuida do resto.

---

## 💡 Analogia

- Imperativo → “faça isso agora”
- Declarativo → “quero que o estado seja assim”

> Kubernetes trabalha com **estado desejado (desired state)**

---

## 📄 Estrutura básica de um YAML

Todo recurso Kubernetes segue esse padrão:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: exemplo
spec:
  containers:
    - name: app
      image: nginx
```

---

## 🧩 Explicando cada parte

| Campo       | O que faz                              |
|-------------|----------------------------------------|
| apiVersion  | Versão da API                          |
| kind        | Tipo do recurso (Pod, Deployment...)   |
| metadata    | Nome, labels, etc                      |
| spec        | Configuração do recurso                |

---

## 🧪 Criando um Pod com YAML (com página customizada)

Crie um arquivo:

```bash
touch pod.yaml
```

Conteúdo:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-yaml
  labels:
    app: nginx-yaml
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
              <title>Hello Kubernetes</title>
            </head>
            <body>
              <h1>Hello Kubernetes</h1>
              <p>Pod criado com YAML declarativo.</p>
            </body>
          </html>
          EOF
          nginx -g 'daemon off;'
```

---

## 🚀 Aplicando o arquivo

```bash
kubectl apply -f pod.yaml
```

Verifique:

```bash
kubectl get pods
```

---

## 🌍 Testando o Pod no navegador

Nesta etapa do curso, vamos manter o básico: acessar o Pod com `port-forward`.

```bash
kubectl port-forward --address 0.0.0.0 pod/nginx-yaml <SUA_PORTA>:80
```

Abra no navegador:

> Adquira o IP da sua máquina: acesse a aba "Informações do lab" para pegar IP e abra no seu navegador:
```html
http://<IP_DA_MAQUINA>:<SUA_PORTA>

exemplo: http://20.127.19.164:<SUA_PORTA>/
```

👉 Você deverá ver a página **Hello Kubernetes** customizada.


---

## 🔄 Atualizando recursos

Altere o YAML (ex: conteúdo do `index.html` ou imagem docker) e rode novamente:

```bash
kubectl delete pod nginx-yaml
kubectl apply -f pod.yaml
```

👉 Nesse caso usamos `delete + apply` porque alguns campos de Pod são imutáveis.

---

## ❌ Removendo recursos

```bash
kubectl delete -f pod.yaml
```

---

## 📌 Gerando YAML automaticamente

Você pode usar o modo imperativo para gerar YAML:

```bash
kubectl run nginx --image=nginx --dry-run=client -o yaml
```

> ℹ️ Esse comando não cria nada no cluster — ele só gera e imprime o YAML que seria criado.
> - `kubectl run nginx --image=nginx`: montaria um Pod chamado nginx com imagem nginx
> - `--dry-run=client`: simula localmente (sem enviar para o Kubernetes)
> - `-o yaml`: mostra o resultado no formato YAML

> Na prática, ele serve para você:
> - aprender a estrutura do manifesto;
> - usar como “rascunho” inicial;
> - salvar e editar antes de aplicar.

💡 Excelente para aprender e acelerar.

---

## ⚠️ Boas práticas

- Sempre use YAML em projetos reais
- Versione no Git
- Evite editar direto via CLI

---

## 🏆 Desafio extra

- Gere um YAML com `kubectl run`
- Salve em arquivo
- Aplique com `kubectl apply`
- Delete com `kubectl delete`

---

## 💡 Reflexão

O que mudou?

- Você deixou de dar comandos diretos
- Passou a definir o estado desejado
- Kubernetes virou um “controlador automático”

---

## Próximo passo

No próximo capítulo você vai:

👉 Criar **Deployments**  
👉 Escalar aplicações  
👉 Entender como rodar apps de verdade no Kubernetes
