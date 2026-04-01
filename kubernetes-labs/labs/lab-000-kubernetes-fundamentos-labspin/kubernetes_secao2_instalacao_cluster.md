# Instalando Kubernetes e criando seu primeiro cluster

Agora vamos sair da teoria e começar a colocar a mão na massa 🚀

Neste laboratório você vai:

- Instalar o Kubernetes localmente usando **kind**
- Validar a instalação do **kubectl**
- Criar seu primeiro cluster
- Executar comandos básicos

---

## ⚠️ Ambiente LabSpin

Neste ambiente você **não tem permissão de sudo**.

👉 Vamos instalar tudo localmente usando `$HOME/bin`

---

## O que vamos usar

- **Docker** → plataforma que permite rodar containers (base do Kubernetes)
- **kubectl** → ferramenta de linha de comando para interagir com o Kubernetes
- **kind (Kubernetes IN Docker)** → ferramenta que cria clusters Kubernetes locais usando Docker

---

## Passo 1 — Verifique o Docker

```bash
docker --version
docker run hello-world
```

---

## Passo 2 — Instalar o kubectl (sem sudo)

Baixe o binário:

```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
```

Dê permissão de execução:

```bash
chmod +x kubectl
```

Crie diretório local de binários:

```bash
mkdir -p $HOME/bin
```

Mova o kubectl:

```bash
mv kubectl $HOME/bin/
```

Adicione ao PATH:

```bash
export PATH=$HOME/bin:$PATH
```

Teste:

```bash
kubectl version --client
```

---

## Passo 3 — Instalar o kind (sem sudo)

Baixe o binário:

```bash
curl -Lo kind https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64
```

Dê permissão:

```bash
chmod +x kind
```

Mova para o diretório local:

```bash
mv kind $HOME/bin/
```

(Reaproveita o PATH já configurado)

Teste:

```bash
kind --version
```

---

## Passo 4 — Criar o cluster

```bash
kind create cluster --name labspin
```

---

## Passo 5 — Verificar o cluster

```bash
kubectl get nodes
```

---

## Passo 6 — Explorando o cluster

```bash
kubectl cluster-info
kubectl get all
kubectl get namespaces
```

---

## Passo 7 — Criando seu primeiro Pod

Antes de subir o nginx, vamos baixar uma página HTML personalizada da Toolbox Tech para rodar no container.

```bash
curl -L https://raw.githubusercontent.com/toolbox-playground/hello-world-com-docker-languages/main/python/templates/index.html -o index.html
```

Agora suba o nginx:
```bash
kubectl run nginx --image=nginx --port=80
kubectl get pods
```

Substitua a página padrão do nginx pela página de baixamos :
```bash
kubectl cp index.html nginx:/usr/share/nginx/html/index.html
```

---

## Passo 8 — Exponha cesse seu serviço através da internet e acesse pelo navegador

```bash
kubectl port-forward --address 0.0.0.0 pod/nginx 800<SUA_PORTA_DO_LAB>:80
```


Adquira o IP da sua máquina e acesse na aba "Informações do lab"e acesse no seu navegador:
```html
http://<IP_DA_MAQUINA>:<SUA_PORTA>

exemplo: http://20.127.19.164:8000/
```

> **Nota**: se der erro `Unable to listen onport 800x: bind: address already in use`, você antes derrubar o container atual que está usando esta porta primeiro com os seguintes comandos:
```bash
docker ps.  # para verificar qual containerID usa a porta 800x
docker rm -f <NOME_OU_ID_DO_CONTAINER>.  # para deletar o container usando essa porta
```

---

## 🏆 Desafio extra

- Crie dois pods nginx
- Veja logs
- Delete um

---

## Próximo passo

👉 Comandos essenciais com kubectl
