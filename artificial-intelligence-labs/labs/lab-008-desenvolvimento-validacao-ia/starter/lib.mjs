// Funções puras do painel (usadas no navegador e nos testes com node --test).
export const STATUS = ['online', 'degraded', 'offline'];

export function formatHora(iso) {
  const d = new Date(iso);
  return `${String(d.getUTCHours()).padStart(2, '0')}:${String(d.getUTCMinutes()).padStart(2, '0')} UTC`;
}
