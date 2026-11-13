# Lab 007 · guia do instrutor (gabarito)

## Falha injetada

`scripts/inject-fault.sh service-selector` faz, no cluster e no manifesto do workspace:

```bash
kubectl --context kind-tbx-aiops --namespace tbx-ai-lab patch service web --type merge -p '{"spec":{"selector":{"app":"web-v2"}}}'
```

Os Pods do Deployment `web` continuam com `app=web`. O Service passa a selecionar `app=web-v2`: nenhum Pod, EndpointSlice vazio, requisição pelo Service falha.

## Evidências esperadas

- `kubectl get pods --show-labels` → Pod `1/1 Running`, label `app=web`.
- `kubectl describe service web` → `Selector: app=web-v2`, `Endpoints:` vazio.
- `kubectl get endpointslices -l kubernetes.io/service-name=web` → sem endereços.
- Requisição do Pod `client` para `http://web/` → falha de conexão.

## Correção esperada

`workspace/manifests/30-service.yaml`: `app: web-v2` → `app: web`, e `kubectl --context kind-tbx-aiops apply -f manifests/`. Não aceitar: mudar o label dos Pods para casar com o Service, corrigir só com `kubectl edit`/`patch` deixando o manifesto errado, ou usar `port-forward` como única prova (ele conecta direto num Pod).

## Ensaio

Os scripts deste lab seguem o mesmo padrão do lab 006 (estado saudável comprovado antes da falha). O mesmo cenário (selector errado → EndpointSlice vazio → correção no manifesto → 200 pelo Service) foi executado de ponta a ponta num cluster kind em 13/11/2026, numa sessão real do Claude Code usada na aula 04-3. Veja a seção "Ensaio dos scripts" abaixo para o resultado dos scripts deste lab.

## Ensaio dos scripts (13/11/2026) · validação incompleta

| Etapa | Resultado |
|---|---|
| Criação do cluster kind `tbx-aiops` | ok, porém lenta (12 min) com o Docker disputando CPU com outro container pesado |
| Ajustes feitos a partir do ensaio | espera do nó Ready; espera da service account `default` antes de criar o Pod `client`; imagens carregadas com `kind load docker-image`; readiness probe com mais folga |
| `setup.sh --state broken` completo | **pendente**: a API do cluster deu timeout (TLS handshake) por falta de CPU no Docker. Repetir com o Docker livre antes de gravar |

Com o Docker livre (2+ CPUs disponíveis), rode `setup.sh --state broken` → corrija o manifesto → `verify.sh --state healthy` → `reset.sh --state broken` → `teardown.sh` e registre aqui.
