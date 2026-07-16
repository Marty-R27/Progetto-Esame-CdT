/* global pulisciTuttiIColori */
// CLIC SULL'IMMAGINE -> EVIDENZIA TESTO E IMMAGINE
document.querySelectorAll('.line-overlay').forEach(poly => {
  poly.addEventListener('click', (e) => {
    e.stopPropagation(); // Evita che il click si propaghi al document
    
    // Pulisce tutti i colori semantici se si clicca sull'immagine
    if (typeof pulisciTuttiIColori === 'function') {
        pulisciTuttiIColori();
    }

    const baseId = poly.id.replace('line-', '');
    
    // Rimuove l'evidenziazione dai poligoni sull'immagine
    document.querySelectorAll('.line-overlay.highlight').forEach(el => el.classList.remove('highlight'));
    poly.classList.add('highlight');
    
    // Cerca il marker nel testo
    const startMarker = document.getElementById('text-' + baseId);
    if (startMarker) {
      evidenziaTestoTraMarker(startMarker);
      startMarker.scrollIntoView({behavior: 'smooth', block: 'center'});
    }
  });
});

// CLIC SUL TESTO -> EVIDENZIA IMMAGINE E TESTO
document.addEventListener('click', (e) => {
  // Supporto Cross-Browser per trovare il nodo di testo cliccato
  let nodoClic = e.target;
  
  if (document.caretPositionFromPoint) { // Standard Firefox
    const pos = document.caretPositionFromPoint(e.clientX, e.clientY);
    if (pos && pos.offsetNode) {
      nodoClic = pos.offsetNode;
    }
  } else if (document.caretRangeFromPoint) { // Webkit & Blink (Chrome, Safari, Edge)
    const range = document.caretRangeFromPoint(e.clientX, e.clientY);
    if (range && range.startContainer) {
      nodoClic = range.startContainer;
    }
  }

  const marker = e.target.closest('.text-line') || trovaMarkerPrecedente(nodoClic);
  
  if (marker && marker.classList.contains('text-line')) {
    const baseId = marker.id.replace('text-', '');
    
    // --- GESTIONE ECCEZIONE COLORI SEMANTICI ---
    // Controlliamo se il click è avvenuto dentro un'entità o termine notevole
    const selettoriSemantici = '.persona, .luogo, .opera, .organizzazione, .verismo, .lessico, .forma_letteraria, .ref, .rs, .verbum, .stile';
    const cliccatoSuEntita = e.target.closest(selettoriSemantici);
    
    // Se non abbiamo cliccato su un'entità, spegniamo tutti i colori semantici
    if (!cliccatoSuEntita && typeof pulisciTuttiIColori === 'function') {
        pulisciTuttiIColori();
    }

    // Rimuove l'evidenziazione precedente dall'immagine
    document.querySelectorAll('.line-overlay.highlight').forEach(el => el.classList.remove('highlight'));
    
    // Evidenzia il poligono corrispondente sull'immagine
    const poly = document.getElementById('line-' + baseId);
    if (poly) poly.classList.add('highlight');
    
    // Evidenzia la riga di testo
    evidenziaTestoTraMarker(marker);
  }
});

// -- FUNZIONE CHE COLORA IL TESTO (AGGIORNATA PER PROSA E POESIA) --
function evidenziaTestoTraMarker(startNode) {
  if (!CSS.highlights) return;

  const range = new Range();

  // Se il nodo è un DIV (come nei versi della poesia), evidenzia il suo contenuto
  if (startNode.tagName.toLowerCase() === 'div') {
      range.selectNodeContents(startNode);
  } 
  // Se è uno SPAN (come i marker della prosa), usa la logica da marker a marker
  else {
      const tuttiIMarker = Array.from(document.querySelectorAll('.text-line'));
      const indicePartenza = tuttiIMarker.indexOf(startNode);
      let endNode = null;
      
      if (indicePartenza !== -1 && indicePartenza < tuttiIMarker.length - 1) {
        endNode = tuttiIMarker[indicePartenza + 1];
      }

      range.setStartAfter(startNode);
      // Cerca il contenitore (può essere un paragrafo, una strofa, o il riquadro principale)
      const container = startNode.closest('p, .stanza, .text-pane'); 
      if (!container) return; // Esce in sicurezza se non c'è un contenitore valido
      
      if (endNode && container && container.contains(endNode)) {
        range.setEndBefore(endNode);
      } else {
        range.setEndAfter(container.lastChild);
      }
  }

  const highlight = new Highlight(range);
  CSS.highlights.clear(); 
  CSS.highlights.set('riga-evidenziata', highlight);
}

// -- FUNZIONE PER TROVARE IL MARKER PRECEDENTE (AGGIORNATA) --
function trovaMarkerPrecedente(node) {
  if (!node) return null;
  const tuttiIMarker = Array.from(document.querySelectorAll('.text-line'));
  const elementoRiferimento = node.nodeType === Node.TEXT_NODE ? node.parentElement : node;

  // Accetta sia p che .stanza che il blocco di testo generico
  if (!elementoRiferimento || !elementoRiferimento.closest('p, .stanza, .text-pane')) return null;
  
  for (let i = tuttiIMarker.length - 1; i >= 0; i--) {
    if (tuttiIMarker[i].compareDocumentPosition(node) & Node.DOCUMENT_POSITION_FOLLOWING) {
      return tuttiIMarker[i];
    }
  }
  return null;
}