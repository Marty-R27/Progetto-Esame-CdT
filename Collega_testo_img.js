//img->testo
document.querySelectorAll('.line-overlay').forEach(poly => { 
  poly.addEventListener('click', () => { //al click sull'img
    const baseId = poly.id.replace('line-', '');
    document.querySelectorAll('.text-line.highlight, .line-overlay.highlight') //rimuove evid. accumulate in testo dopo click su img -
      .forEach(el => el.classList.remove('highlight')); //toglie evid. accumulata dal testo se premi img*
    poly.classList.add('highlight'); //?
    const textEl = document.getElementById('text-' + baseId); //id="text-nome" id per evid testo al click su img
    textEl?.classList.add('highlight'); //evidenzia la riga del testo al click sulla riga img
    textEl?.scrollIntoView({behavior: 'smooth', block: 'center'});
  });
});

//testo->img 
document.querySelectorAll('.text-line').forEach(zone => { 
  zone.addEventListener('click', () => { // al click sul testo
    const baseId = zone.id.replace('text-', '');
    document.querySelectorAll('.text-line.highlight, .line-overlay.highlight') //rimuove evid. accum. in img dopo click su img 
      .forEach(el => el.classList.remove('highlight')); //rimuove evid. accumulate testo se click su testo*
    zone.classList.add('highlight'); //evid. testo 
    document.getElementById('line-' + baseId)?.classList.add('highlight'); //evid. img se click su testo
  });
});

/*------------------------*/ 



