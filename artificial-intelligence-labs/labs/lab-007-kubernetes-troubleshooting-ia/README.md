# Lab 007 - Troubleshooting Kubernetes com agente de IA

## Objetivo

Subir um cluster Kubernetes local (kind) com uma aplicação saudável, quebrar o Service de propósito e pedir ao **Claude Code** ou ao **Codex** que investigue com `kubectl`, mostre as evidências, proponha a correção **no manifesto** e só aplique depois da sua aprovação.

O sintoma: o Deployment está saudável, mas a aplicação não responde pelo Service.

## Dificuldade e tempo

- Dificuldade: Intermediário
- Tempo estimado: 12 a 18 minutos (sem contar a criação do cluster, 1 a 3 minutos)

## Arquitetura

```text
cluster kind "tbx-aiops" · namespace "tbx-ai-lab"
  Pod client (curl) ──► Service web:80 ──► Pods do Deployment web (nginx, label app=web)
```

Todos os comandos usam o contexto `kind-tbx-aiops` de forma explícita: o lab não troca o seu contexto atual do kubectl.

## Pré-requisitos

| Ferramenta | Como conferir |
|---|---|
| Docker rodando (com pelo menos 2 CPUs livres) | `docker info` |
| kind | `kind version` · [instalação](https://kind.sigs.k8s.io/docs/user/quick-start/#installation) |
| kubectl | `kubectl version --client` · [instalação](https://kubernetes.io/docs/tasks/tools/) |
| Claude Code **ou** Codex | `claude --version` ou `codex --version` |

No Windows, use o WSL2 com o Docker Desktop integrado.

## Passo a passo

### 1. Criar o cluster e a aplicação saudável

```bash
cd artificial-intelligence-labs/labs/lab-007-kubernetes-troubleshooting-ia
bash scripts/setup.sh --state healthy
```

O script cria o cluster `tbx-aiops` (só se ainda não existir um criado por este lab), aplica os manifestos de `workspace/manifests/`, espera o rollout e confirma uma requisição nova a `http://web/` de dentro do cluster.

### 2. Provocar a falha

```bash
bash scripts/inject-fault.sh service-selector
kubectl --context kind-tbx-aiops -n tbx-ai-lab get deploy,pods
kubectl --context kind-tbx-aiops -n tbx-ai-lab exec client -- curl -s -m 5 http://web/
```

O Deployment segue Ready, mas a requisição pelo Service falha.

### 3. Abrir o agente no workspace

```bash
cd workspace
claude      # ou: codex
```

### 4. Pedir o troubleshooting

```text
A aplicação deste laboratório está inacessível pelo Service, embora o Deployment pareça saudável.
Investigue o namespace tbx-ai-lab no contexto kind-tbx-aiops e os manifests deste workspace.
Não altere outros namespaces ou clusters. Primeiro apresente evidências e uma proposta de correção;
depois de eu aprovar, corrija a fonte declarativa e valide uma nova requisição pelo Service.
```

Acompanhe o loop: o agente roda `kubectl get`/`describe`, lê labels, selector e EndpointSlices e decide o próximo comando. Antes do `kubectl apply`, ele deve parar e pedir aprovação.

### 5. Aprovar e conferir

```bash
cd ..
bash scripts/verify.sh --state healthy
```

### 6. Repetir ou limpar

```bash
bash scripts/reset.sh --state broken   # volta ao defeito
bash scripts/teardown.sh               # apaga o cluster tbx-aiops (só se foi criado por este lab)
```

## Critério de conclusão

- Causa identificada com evidência (labels dos Pods × selector do Service × EndpointSlice vazio).
- Correção no manifesto (`workspace/manifests/30-service.yaml`) e no cluster, sem divergência.
- `verify.sh --state healthy` passa: Pod Ready, EndpointSlice com destino Ready e `http://web/` → 200 com a página do lab.

## Referências

- [kind: quick start](https://kind.sigs.k8s.io/docs/user/quick-start/)
- [Kubernetes: Debug Services](https://kubernetes.io/docs/tasks/debug/debug-application/debug-service/)
- [EndpointSlices](https://kubernetes.io/docs/concepts/services-networking/endpoint-slices/)
- Aula 04-3 do curso: troubleshooting Kubernetes com agente.
