# Kubernetes - Fundamentos

## O problema

Você já percebeu que rodar **um container** é fácil… mas rodar **vários containers em produção** é outra história?

Imagine o cenário:

- Você tem 10 containers rodando sua aplicação
- Um deles cai inesperadamente
- O tráfego aumenta e você precisa de mais instâncias
- Você precisa atualizar a aplicação sem downtime

**Resultado: complexidade operacional explode**

---

## A solução: Kubernetes

O **Kubernetes (K8s)** é uma plataforma de **orquestração de containers**.

Ele resolve automaticamente problemas como:

- 🔄 Reiniciar containers que falham  
- 📈 Escalar sua aplicação (mais ou menos instâncias)  
- 🌐 Expor serviços na rede  
- 🚀 Fazer deploy e update sem downtime  

---

## Analogia simples

- Docker → cria e roda containers  
- Kubernetes → gerencia vários containers em produção  

> **Analogia:**  
> Docker é como ter um carro.  
> Kubernetes é como um sistema inteligente de gestão de frota inteira.

---

## Como o Kubernetes funciona [(Arquitetura simplificada)](https://kubernetes.io/docs/concepts/architecture/)

Aplicação → Container → Pod → Cluster Kubernetes

- **Container**: é onde sua aplicação realmente roda.
- **Pod**: é a menor unidade do Kubernetes e normalmente encapsula um container.
- **Node**: é a máquina, virtual ou física, que executa os Pods.
- **Cluster**: é o conjunto de nodes gerenciados pelo Kubernetes.
- **Control Plane**: é a parte que coordena o cluster e decide o que deve rodar, onde e de que forma.

---

De forma prática, o Kubernetes organiza o ambiente em duas grandes camadas:

- **Control Plane**: é a camada de controle do cluster.
  - Recebe comandos do usuário.
  - Decide onde os Pods devem rodar.
  - Garante que o estado atual fique próximo do estado desejado.
  - Armazena as informações do cluster.
- **Worker Nodes**: são as máquinas que executam as aplicações.
  - Rodam os Pods.
  - Mantêm os containers ativos.
  - Cuidam da comunicação de rede entre Pods e serviços.

### Como interpretar essa estrutura [(K8s componentes)](https://kubernetes.io/docs/concepts/overview/components/)

- O usuário interage com o cluster usando **kubectl**.
- O **API Server** recebe esses comandos e funciona como porta de entrada do Kubernetes.
- O **Scheduler** decide em qual node cada Pod será executado.
- O **Controller Manager** verifica continuamente se o cluster está no estado esperado.
- O **etcd** guarda o estado e as informações importantes do cluster.
- Em cada **Worker Node**, o **Kubelet** garante que os Pods estejam rodando corretamente.
- O **kube-proxy** ajuda a manter a comunicação de rede entre serviços e Pods.

Em resumo:

- **Control Plane = gerencia e toma decisões**
- **Worker Nodes = executam a aplicação**

---

## Principais componentes

| Componente       | Função                                                                 |
|-----------------|------------------------------------------------------------------------|
| API Server       | Porta de entrada do Kubernetes                                         |
| Scheduler        | Decide onde os Pods serão executados                                   |
| Controller       | Garante que o estado desejado seja mantido                             |
| Kubelet          | Agente que roda em cada node                                           |
| kube-proxy       | Ajuda a rotear o tráfego de rede para os serviços e Pods               |
| etcd             | Banco de dados do cluster                                              |

---

## Separando Control Plane e Worker Node

### Control Plane
É a parte que **gerencia** o cluster.

Ele:
- recebe comandos
- toma decisões
- agenda Pods
- mantém o estado desejado

### Worker Node
É a parte que **executa** as aplicações.

Ele:
- roda os Pods
- executa containers
- reporta status para o Control Plane

👉 Em resumo:

- **Control Plane = cérebro**
- **Worker Node = braços e pernas**

---

## Kubernetes vs Docker

| Característica        | Docker                    | Kubernetes                        |
|----------------------|--------------------------|----------------------------------|
| Foco                 | Container individual     | Orquestração de containers       |
| Escalabilidade       | Manual                   | Automática                       |
| Alta disponibilidade | Limitada                 | Nativa                           |
| Deploy               | Simples                  | Declarativo (YAML)               |

---

## Quando usar Kubernetes?

Você normalmente usa Kubernetes quando:

- Tem múltiplos containers
- Precisa de alta disponibilidade
- Quer escalar automaticamente
- Está rodando em produção

---

## O que vamos fazer neste módulo

Ao longo deste laboratório você vai:

- Criar seu primeiro cluster local com **kind**
- Executar comandos básicos com **kubectl**
- Subir seu primeiro **Pod**
- Criar um **Deployment**
- Expor sua aplicação

---

## Próximo passo

No próximo capítulo, você vai:

👉 Instalar e validar o Kubernetes localmente  
👉 Criar seu primeiro cluster  
👉 Rodar os primeiros comandos (`kubectl get nodes`)
