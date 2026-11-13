# Runbook pedidos-api · versão 1 (OBSOLETA)

- **Versão:** 1 · **Atualizado em:** 2025-03-14 · **Status:** substituída pela versão 3

## Arquitetura (2025)
O backend rodava direto na VM `pedidos-01`, na porta **8080**, sem proxy.

## Reinício
`sudo systemctl restart pedidos-api` na VM `pedidos-01`.

## Retenção de logs
Os logs ficavam em `/var/log/pedidos-api/` com retenção de **14 dias** (logrotate).
