import {formatHora} from './lib.mjs';

const lista = document.querySelector('#servicos');
const servicos = await (await fetch('./data/services.json')).json();

// Ponto de partida: lista todos os serviços, sem filtro e sem tratar status ausente.
lista.innerHTML = servicos.map((s) => `
  <li>
    <strong>${s.nome}</strong> · ${s.time}
    <span class="status">${s.status}</span>
    <small>${formatHora(s.atualizado)}</small>
  </li>`).join('');
