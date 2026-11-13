# Prompts do lab 007

## Pedido inicial (sessão nova, dentro de `workspace/`)

```text
A aplicação deste laboratório está inacessível pelo Service, embora o Deployment pareça saudável.
Investigue o namespace tbx-ai-lab no contexto kind-tbx-aiops e os manifests deste workspace.
Não altere outros namespaces ou clusters. Primeiro apresente evidências e uma proposta de correção;
depois de eu aprovar, corrija a fonte declarativa e valide uma nova requisição pelo Service.
```

## Aprovação

```text
Aprovado. Corrija o manifesto, aplique com kubectl apply e valide com uma requisição nova
pelo Service, de dentro do cluster.
```

## Se o agente corrigir só o objeto vivo

```text
Corrija também o manifesto em workspace/manifests: senão o próximo apply traz o erro de volta.
```
