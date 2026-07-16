<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                version="2.0"
                exclude-result-prefixes="tei">
  
  <xsl:output method="html" encoding="UTF-8" version="5" indent="yes"/> 
  <xsl:strip-space elements="*"/> 
  <!-- <xsl:preserve-space elements="tei:persName tei:placeName tei:orgName"/> -->
  
  <!-- Variabili che leggono i file esterni -->
  <xsl:variable name="persons" select="document('coverlessListPerson.xml')//tei:person"/>
  <xsl:variable name="places" select="document('coverlessListPlace.xml')//tei:place"/>
  <xsl:variable name="works" select="document('coverlessListWork.xml')//tei:biblStruct"/>
  <xsl:variable name="organizations" select="document('coverlessListOrganization.xml')//tei:org"/>
  <xsl:variable name="taxonomy" select="document('coverlessTassonomia.xml')//tei:category"/>
  
  <xsl:variable name="terms" select="//tei:term[@subtype]"/>
  
  <!-- BLOCCO 1 -->
  <xsl:template match="/">
    <html lang="it">
      <head>
        <!-- Titolo della scheda del browser -->
        <title><xsl:value-of select="//tei:titleStmt/tei:title"/></title> 
        <link rel="stylesheet" href="CSS.css"/>
      </head>
      <body>
        <!-- Titolo e Autore che compaiono in cima alla pagina web -->
        <h1 class="title">
          <xsl:value-of select="//tei:titleStmt/tei:title"/>
        </h1>
        <p class="autore">
          di <xsl:value-of select="//tei:sourceDesc//tei:author"/>
        </p>
        
        <div class="edition-layout">
          
          <!-- COLONNA 1: L'immagine e la lente -->
          <xsl:apply-templates select="//tei:surface"/>
          
          <!-- COLONNA 2: Il testo trascritto -->
          <div class="text-pane">
            <xsl:apply-templates select="//tei:text"/>
          </div>   
          
          <!-- COLONNA 3: Le informazioni extra -->
          <div class="info_p" id="person-data">
              
              <xsl:apply-templates select="$persons" mode="info-card"/>
              <xsl:apply-templates select="$places" mode="info-card"/>
              <xsl:apply-templates select="$works" mode="info-card"/>
              <xsl:apply-templates select="$organizations" mode="info-card"/>
              <xsl:apply-templates select="$taxonomy" mode="info-card"/>
            
              <xsl:for-each-group select="$terms" group-by="@subtype">
                  <xsl:apply-templates select="." mode="info-card"/>
              </xsl:for-each-group>
              
              <details onclick="Show(this)">
                <summary>Legenda</summary>
                <img src="legenda1.png" alt="Legenda"/> 
              </details>
            </div>          
          
          </div>
        
        <script src="Box_entita1.js"></script>
        <script src="Collega_testo_img1.js"></script>
        <script src="Lente1.js"></script>
        
        <footer>
          <xsl:text>Martina Ricci e Beatrice Longhi - Cdt 2026</xsl:text>
        </footer>
        
      </body>
    </html>
  
  </xsl:template>

<!-- TEMPLATES IN MODALITA' INFO-CARD -->

<!-- Info-card -->
  <!-- Info-card Person -->
  <xsl:template match="tei:person" mode="info-card">
    <div class="view_info" id="{(@xml:id, generate-id())[1]}">
      <xsl:variable name="name" select="normalize-space(string-join(if (tei:persName/tei:forename or tei:persName/tei:surname) then tei:persName/(tei:forename | tei:surname) else tei:persName/text(), ' '))"/>
      <xsl:if test="$name != ''">
        <h3><xsl:value-of select="$name"/></h3>
      </xsl:if>
      <xsl:if test="tei:note">
        <div class="note-text">
          <xsl:apply-templates select="tei:note" mode="info-card"/>
        </div>
      </xsl:if>
    </div>
  </xsl:template>
  
  <!-- Info-card Place -->
  <xsl:template match="tei:place" mode="info-card">
    <div class="view_info" id="{(@xml:id, generate-id())[1]}">
      <xsl:variable name="place" select="normalize-space(string-join(tei:placeName/text(), ' '))"/>
      <xsl:if test="$place != ''">
        <h3><xsl:value-of select="$place"/></h3>
      </xsl:if>
      <xsl:if test="tei:placeName/tei:note or tei:country">
        <div class="note-text">
          <xsl:choose>
            <xsl:when test="tei:placeName/tei:note">
              <xsl:apply-templates select=".//tei:note" mode="info-card"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="normalize-space(tei:country[1])"/>
            </xsl:otherwise>
          </xsl:choose>
        </div>
      </xsl:if>
    </div>
  </xsl:template>
  
  <!-- Info-card Organization -->
  <xsl:template match="tei:org" mode="info-card">
    <div class="view_info" id="{(@xml:id, generate-id())[1]}">
      <xsl:variable name="org" select="normalize-space(string-join(tei:orgName/text(), ' '))"/>
      <xsl:if test="$org != ''">
        <h3><xsl:value-of select="$org"/></h3>
      </xsl:if>
      <xsl:if test="tei:desc">
        <div class="note-text">
          <xsl:apply-templates select="tei:desc" mode="info-card"/>
        </div>
      </xsl:if>
    </div>
  </xsl:template>
  
  <!-- Info-card Work -->
  <xsl:template match="tei:biblStruct" mode="info-card">
    <div class="view_info" id="{(@xml:id, generate-id())[1]}">
      <xsl:variable name="title" select="normalize-space(string-join(tei:monogr/tei:title[@type='main']/text(), ' '))"/>
      <xsl:if test="$title != ''">
        <h3><xsl:value-of select="$title"/></h3>
      </xsl:if>
      <xsl:if test="tei:monogr/tei:imprint">
        <div class="note-text">
          <xsl:apply-templates select="tei:monogr/tei:imprint" mode="info-card"/>
        </div>
      </xsl:if>
    </div>
  </xsl:template>
  
  <xsl:template match="tei:category" mode="info-card">
    <div class="sub_info {@xml:id}">
      <h3>Ambito particolare:</h3> 
      <p><xsl:value-of select="tei:catDesc"/></p>
    </div>
  </xsl:template>
  
  <xsl:template match="tei:term" mode="info-card">
    <div class="sub_info {@subtype}">
      <h3>Categoria: <xsl:value-of select="@subtype"/></h3>
      <div class="note-text">
        <p>
          <xsl:choose>
            <xsl:when test="@type='verbum'">Termine ed espressione rilevante per il contesto verista.</xsl:when>
            <xsl:when test="@type='stile'">Termine rilevante dal punto di vista lessicale e sintattico.</xsl:when>
            <xsl:when test="@type='forma_letteraria'">Elemento di identificazione della forma letteraria.</xsl:when>
            <xsl:otherwise>Termine notevole evidenziato nel testo.</xsl:otherwise>
          </xsl:choose>
        </p>
      </div>
    </div>
  </xsl:template>

<!-- Template di supporto per i testi dentro le info-card -->
<xsl:template match="tei:note" mode="info-card">
  <div><xsl:apply-templates/></div>
</xsl:template>
  
<xsl:template match="tei:note[@type='editorial']" mode="info-card">
 </xsl:template>
  
<xsl:template match="tei:note[@type='editorial']" />
  
<xsl:template match="tei:desc" mode="info-card">
  <div><xsl:apply-templates/></div>
 </xsl:template>

<xsl:template match="tei:imprint" mode="info-card">
  <p><xsl:value-of select="tei:publisher"/><xsl:text>, </xsl:text><xsl:value-of select="tei:pubPlace"/><xsl:text>, </xsl:text><xsl:value-of select="tei:date"/></p>
</xsl:template>

<!-- BLOCCO 4: Immagine e Aree SVG -->

<xsl:template match="tei:surface">
  <div class="viewer-pane">
    <button id="mode-toggle" type="button">🔍</button>
    <div id="image-zoomer-box">
      <!-- Immagine di base -->
      <img id="img-1" alt="Pagina sorgente del testo codificato" src="{tei:graphic/@url}"/>
      
      <!-- SVG sovrapposto per le zone interattive -->
      <svg class="overlay" viewBox="0 0 {substring-before(tei:graphic/@width,'px')} {substring-before(tei:graphic/@height,'px')}">
        <xsl:apply-templates select=".//tei:zone[@rend='line']" mode="overlay"/>
      </svg>
      
      <!-- Div per la lente di ingrandimento (Lente1.js) -->
      <div id="img-2" style="background-image: url('{tei:graphic/@url}');"></div>
    </div>
  </div>
</xsl:template>

<!-- Trasformazione delle zone TEI in rettangoli SVG -->
<xsl:template match="tei:zone[@rend='line']" mode="overlay">
  <!-- Estraggo l'ID pulito per permettere al JS di collegare la riga SVG al testo.
       Dal tuo XML, l'ID è es: "Farfalla_1877_4_4_45_p1_l1". 
       Rimuovendo il prefisso, l'ID dell'SVG diventa: "line-p1_l1". -->
  <rect id="line-{substring-after(@xml:id, 'Farfalla_1877_4_4_45_')}" class="line-overlay"
        x="{@ulx}" y="{@uly}"
        width="{@lrx - @ulx}" height="{@lry - @uly}"/>
</xsl:template>

<!-- Interruzione di Pagina -->
  <xsl:template match="tei:pb">
    <div class="page-break" id="{@xml:id}">
      <!-- Nel CSS potrai stileggiarlo (es. linea separatrice) -->
      <span>[Pagina <xsl:value-of select="substring-after(@facs, 'Farfalla_1877_4_4_')"/>]</span>
    </div>
  </xsl:template>

<!-- L'interruzione di colonna (<cb>) per ora la nascondiamo per non sporcare il flusso del testo -->
<xsl:template match="tei:cb"/>

<!-- BLOCCO 5: Testo, Righe, Parole e Abbreviazioni -->

<!-- Paragrafi -->
<xsl:template match="tei:p">
  <!-- Se hai messo rend="first-line-indented" nell'XML, lo passa al CSS -->
  <p class="{@rend}">
    <xsl:apply-templates/>
  </p>
</xsl:template>

<!-- Interruzioni di riga (fondamentale per le parole spezzate) -->
  <xsl:template match="tei:lb">
    <br/>
    <!-- Il marker che dice al JS "inizia a colorare da qui" -->
    <span id="text-{substring-after(@facs, 'Farfalla_1877_4_4_45_')}" class="text-line">
    </span>
  </xsl:template>

<!-- Parole spezzate (ignorano l'a capo, tengono unita la logica) -->
<xsl:template match="tei:w">
  <span class="w">
    <xsl:apply-templates/>
  </span>
</xsl:template>

<!-- Firma a fine testo -->
  <xsl:template match="tei:signed">
    <div class="firma {@rend}">
      
      <xsl:if test="@facs">
        <span id="text-{substring-after(@facs, 'Farfalla_1877_4_4_45_')}" class="text-line"></span>
      </xsl:if>
      
      <xsl:apply-templates/>
    </div>
  </xsl:template>

<!-- Gestione Abbreviazioni (Il tuo CSS farà la magia con hover) -->
<xsl:template match="tei:choice">
  <span class="choice">
    <xsl:apply-templates/>
  </span>
</xsl:template>

<xsl:template match="tei:abbr">
  <span class="abbr">
    <xsl:apply-templates/>
  </span>
</xsl:template>

<xsl:template match="tei:expan">
  <span class="expan">
    <xsl:apply-templates/>
  </span>
</xsl:template>

<!-- BLOCCO 6: Elementi semantici e interattivi -->

<!-- 1. Intestazioni e Segni -->
  <xsl:template match="tei:head">
    <h2>
      <xsl:attribute name="class">
        <xsl:text>head</xsl:text>
        <xsl:if test="@type">
          <xsl:text> </xsl:text><xsl:value-of select="@type"/>
        </xsl:if>
        <xsl:if test="@rend">
          <xsl:text> </xsl:text><xsl:value-of select="@rend"/>
        </xsl:if>
      </xsl:attribute>
      <xsl:apply-templates/>
    </h2>
  </xsl:template>

<xsl:template match="tei:metamark">
  <div class="trattino {@function}">
    <xsl:apply-templates/>
  </div>
</xsl:template>

<!-- 2. Entità Interattive (Collegate al Javascript) -->
<xsl:template match="tei:persName">
  <span class="persona"
        onclick="mostraRosa(this); mostraInfo('{substring-after(@ref,'#')}')"
        ondblclick="mostraInfo_dbcl('{substring-after(@ref,'#')}')">
    <xsl:apply-templates/>
  </span>
</xsl:template>
  
  <xsl:template match="tei:rs">
    <span class="rs {@type} {@subtype}"
          onclick="mostra{
      if (@type='person' or @type='epithet') then 'Rosa' 
      else if (@type='place') then 'Marrone' 
      else if (@type='work') then 'Verde' 
      else 'Arancione'}(this); mostraInfo('{substring-after(@ref,'#')}')"
          ondblclick="mostraInfo_dbcl('{substring-after(@ref,'#')}')">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

<xsl:template match="tei:placeName">
  <span class="luogo"
        onclick="mostraMarrone(this); mostraInfo('{substring-after(@ref,'#')}')"
        ondblclick="mostraInfo_dbcl('{substring-after(@ref,'#')}')">
    <xsl:apply-templates/>
  </span>
</xsl:template>
  
  <xsl:template match="tei:term">
    <span class="{@type}"
          onclick="mostra{
      if (@type='verbum') then 'Viola' 
      else if (@type='stile') then 'Blu' 
      else 'Rosso'}(this); mostraSub('{@subtype}')"
          ondblclick="mostraSub_dbcl('{@subtype}')"> 
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
  <xsl:template match="tei:ref">
    <span class="ref" 
          onclick="mostraTurchese(this); mostraSub('{substring-after(@target,'#')}')"
          ondblclick="mostraSub_dbcl('{substring-after(@target,'#')}')">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

<!-- 3. Altre classi semantiche presenti nel tuo XML -->
  <xsl:template match="tei:q">
    <span class="q">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

<xsl:template match="tei:hi">
  <span class="hi {@rend}">
    <xsl:apply-templates/>
  </span>
</xsl:template>

<xsl:template match="tei:foreign">
  <span class="foreign" lang="{@xml:lang}">
    <xsl:apply-templates/>
  </span>
</xsl:template>

<xsl:template match="tei:distinct">
  <span class="distinct">
    <xsl:apply-templates/>
  </span>
</xsl:template>

<!-- 4. Supporto specifico per le abbreviazioni XML -->
<xsl:template match="tei:am">
  <span class="am"><xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="tei:ex">
  <span class="ex"><xsl:apply-templates/></span>
</xsl:template>
  
</xsl:stylesheet>