/* eslint-disable no-unused-vars */
// Funzione unificata per pulire TUTTI i colori (Entità + Termini)
function pulisciTuttiIColori() {
  document.querySelectorAll(
    '.rosa-attiva, .marrone-attivo, .arancione-attiva, .verde-attivo, .viola-attiva, .blu-attivo, .rosso-attiva, .turchese-attivo'
  ).forEach(span => {
    span.classList.remove(
      'rosa-attiva', 'marrone-attivo', 'arancione-attiva', 'verde-attivo', 
      'viola-attiva', 'blu-attivo', 'rosso-attiva', 'turchese-attivo'
    );
  });
}

// --- Colori EN ---

function mostraRosa(el) {
  if (!el) return;
  pulisciTuttiIColori();
  el.classList.add('rosa-attiva');
}

function mostraMarrone(el) {
  if (!el) return;
  pulisciTuttiIColori();
  el.classList.add('marrone-attivo');
}

function mostraArancione(el) {
  if (!el) return;
  pulisciTuttiIColori();
  el.classList.add('arancione-attiva');
}

function mostraVerde(el) {
  if (!el) return;
  pulisciTuttiIColori();
  el.classList.add('verde-attivo');
}

// --- Colori Termini ---

function mostraViola(el) {
  if (!el) return;
  pulisciTuttiIColori();
  el.classList.add('viola-attiva');
}

function mostraBlu(el) {
  if (!el) return;
  pulisciTuttiIColori();
  el.classList.add('blu-attivo');
}

function mostraRosso(el) {
  if (!el) return;
  pulisciTuttiIColori();
  el.classList.add('rosso-attiva');
}

// AGGIUNTA MARTY

function mostraTurchese(el) {
  if (!el) return;
  pulisciTuttiIColori();
  el.classList.add('turchese-attivo');
}

// --- Informazioni sulle EN ---

function mostraInfo(id) {
  document.querySelectorAll('.view_info.info-attivo').forEach(div => {
    div.classList.remove('info-attivo');
  });
  document.querySelectorAll('.sub_info.sub-attivo').forEach(div => {
    div.classList.remove('sub-attivo');
  });
  const info = document.getElementById(id);
  if (info) info.classList.add('info-attivo');
}

function mostraInfo_dbcl(id) {
  const info = document.getElementById(id);
  if (info) info.classList.remove('info-attivo');
  pulisciTuttiIColori();
}

// --- Informazioni sui term notevoli ---

function mostraSub(subtype) {
  document.querySelectorAll('.sub_info.sub-attivo').forEach(div => {
    div.classList.remove('sub-attivo');
  });
  document.querySelectorAll('.view_info.info-attivo').forEach(div => {
    div.classList.remove('info-attivo');
  });
  const sub = document.getElementsByClassName(subtype)[0];
  if (sub) sub.classList.add('sub-attivo');
}

function mostraSub_dbcl(subtype) {
  const sub = document.getElementsByClassName(subtype)[0];
  if (sub) sub.classList.remove('sub-attivo');
  pulisciTuttiIColori();
}

/* Mostra Legenda */
function Show(el) {
  if (!el) return;
  if (typeof el.show === 'function') {
    el.show();
  } else if (el.style) {
    el.style.display = 'block';
  }
}