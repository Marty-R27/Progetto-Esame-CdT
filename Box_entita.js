/* eslint-disable no-unused-vars */
//colori EN


function mostraRosa(el) {
    document.querySelectorAll('.persona.rosa-attiva').forEach(span => {
    span.classList.remove('rosa-attiva');
  });
  el.classList.add('rosa-attiva');
}

function mostraMarrone(el) {
    document.querySelectorAll('.luogo.marrone-attivo').forEach(span => {
    span.classList.remove('marrone-attivo');
  });
  el.classList.add('marrone-attivo');
}

function mostraArancione(el) {
    document.querySelectorAll('.opera.arancione-attiva').forEach(span => {
    span.classList.remove('arancione-attiva');
  });
  el.classList.add('arancione-attiva');
}

function mostraVerde(el) {
    document.querySelectorAll('.organizzazione.verde-attivo').forEach(span => {
    span.classList.remove('verde-attivo');
  });
  el.classList.add('verde-attivo');
}

//Colori term

function mostraViola(el) {
    document.querySelectorAll('.verismo.viola-attiva').forEach(span => {
    span.classList.remove('viola-attiva');
  });
  el.classList.add('viola-attiva');
}

function mostraBlu(el) {
    document.querySelectorAll('.lessico.blu-attivo').forEach(span => {
    span.classList.remove('blu-attivo');
  });
  el.classList.add('blu-attivo');
}

function mostraRosso(el) {
    document.querySelectorAll('.forma_letteraria.rosso-attiva').forEach(span => {
    span.classList.remove('rosso-attiva');
  });
  el.classList.add('rosso-attiva');
}

/*Colori temi*/

function mostraCeleste(el) {
    document.querySelectorAll('.tema.celeste-attiva').forEach(span => {
    span.classList.remove('celeste-attiva');
  });
  el.classList.add('celeste-attiva');
}

function noCeleste(el) {
    document.querySelectorAll('.tema.celeste-attiva').forEach(span => {
    span.classList.remove('celeste-attiva');
  });
}







//informazioni sulle EN

function mostraInfo(id) {
  document.querySelectorAll('.view_info.info-attivo').forEach(div => {
    div.classList.remove('info-attivo');
  });
  const info = document.getElementById(id);
  if (info) info.classList.add('info-attivo');
}

function mostraInfo_dbcl(id) {
  const info = document.getElementById(id);
  if (info) info.classList.remove('info-attivo');
}




//informazioni sui term notevoli

function mostraSub(subtype) {
  document.querySelectorAll('.sub_info.sub-attivo').forEach(div => {
    div.classList.remove('sub-attivo');
  });
  const sub = document.getElementsByClassName(subtype)[0];
  if (sub) sub.classList.add('sub-attivo');
}

function mostraSub_dbcl(subtype) {
  const sub = document.getElementsByClassName(subtype)[0];
  if (sub) sub.classList.remove('sub-attivo');
}

/*Temi*/

function mostraTa(target) {
  document.querySelectorAll('.ta_info.ta-attivo').forEach(div => {
    div.classList.remove('ta-attivo');
  });
  const ta = document.getElementsByClassName(target)[0];
  if (ta) ta.classList.add('ta-attivo');
}

function mostraTa_dbcl(target) {
  const ta = document.getElementsByClassName(target)[0];
  if (ta) ta.classList.remove('ta-attivo');
}



/*Mostra Legenda*/

function Show(el) {
  el.show();
}