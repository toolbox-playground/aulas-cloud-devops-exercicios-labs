# Guia do serviço relatorios

- **Versão:** 2 · **Atualizado em:** 2026-08-20

O `relatorios` gera PDFs a partir dos pedidos fechados. Roda como CronJob no Kubernetes, às 02:00 UTC.
Falhas aparecem em `kubectl -n relatorios get jobs`. Este guia **não** cobre a pedidos-api.
