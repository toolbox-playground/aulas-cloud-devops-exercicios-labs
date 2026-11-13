# Prompts do lab 006

## Pedido inicial (sessão nova, dentro de `workspace/`)

```text
Este ambiente de laboratório tem um proxy e um backend, rodando com Docker Compose neste diretório.
A URL http://127.0.0.1:18080/health está falhando. Investigue o workspace e o ambiente em execução,
inicialmente sem alterar nada. Mostre a evidência da causa e proponha a menor correção.
Aguarde minha confirmação antes de aplicá-la. Trabalhe apenas neste projeto; depois confirme o
funcionamento pela mesma URL.
```

## Aprovação

```text
Aprovado. Aplique só essa correção, recarregue o proxy e confirme pela mesma URL.
```

## Se o agente tentar contornar o proxy

```text
Não quero expor o backend nem pular o proxy. Corrija a configuração do proxy para que ele
encaminhe para o backend corretamente.
```
