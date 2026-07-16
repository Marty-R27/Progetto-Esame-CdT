<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                version="2.0"
                exclude-result-prefixes="tei"> <!--Transform per creare l'albero, namespace elem. TEI, no prefisso "tei" -->
    
    <!--xmlns:tei="http://www.tei-c.org/ns/1.0" rimetti sopra nel buco -->
    
    <xsl:output method="html" encoding="UTF-8" version="5" indent="yes"/> 
    <xsl:strip-space elements="*"/> <!--Toglie gli spazi dall'XML in input-->
    <xsl:preserve-space elements="tei:p"/> <!--Tranne p-->
    

    <!--Nuovo per info EN-->
    
    <xsl:variable name="persons" select="document('coverlessListPerson.xml')//tei:person"/>
    <xsl:variable name="places" select="document('coverlessListPlace.xml')//tei:place"/>
    <xsl:variable name="works" select="document('coverlessListWork.xml')//tei:biblStruct"/>
    <xsl:variable name="organizations" select="document('coverlessListOrganization.xml')//tei:org"/>
    <xsl:variable name="terms" select="//tei:term[@subtype]"/>
    <xsl:variable name="themes" select="//tei:ref[@target]"/>

    <xsl:template match="tei:person" mode="info-card">
        <div class="view_info" id="{@xml:id}">
            <h4><xsl:value-of select="tei:persName"/></h4>
            <div class="note-text">
                <xsl:apply-templates select="tei:note" mode="info-card"/>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:place" mode="info-card">
        <div class="view_info" id="{@xml:id}">
            <h4>
                <xsl:choose>
                    <xsl:when test="tei:placeName/tei:settlement">
                        <xsl:value-of select="tei:placeName/tei:settlement"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="tei:placeName"/>
                    </xsl:otherwise>
                </xsl:choose>
            </h4>
            <div class="note-text">
                <xsl:choose>
                    <xsl:when test="tei:placeName/tei:note">
                <xsl:apply-templates select=".//tei:note" mode="info-card"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="tei:country"/>
                    </xsl:otherwise>
                </xsl:choose>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:biblStruct" mode="info-card">
        <div class="view_info" id="{@xml:id}">
            <h4><xsl:value-of select="tei:monogr/tei:title[@type='main']"/></h4>
            <div class="note-text">
                <xsl:apply-templates select="tei:monogr/tei:imprint" mode="info-card"/>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:org" mode="info-card">
        <div class="view_info" id="{@xml:id}">
            <h4><xsl:value-of select="tei:orgName[@type='main']"/></h4>
            <div class="note-text">
                <xsl:apply-templates select="tei:desc" mode="info-card"/>
            </div>
        </div>
    </xsl:template>
    
    
    <xsl:template match="tei:term" mode="info-card">
        <div class="sub_info {@subtype}">
            <h2>Ambito particolare:</h2> 
            <xsl:apply-templates select="@subtype" mode="info-card"/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:term/@subtype" mode="info-card">
        <xsl:value-of select="translate(., '_', ' ')"/>
    </xsl:template>
    
    
    <!--New-->
    <xsl:template match="tei:ref" mode="info-card">
        <div class="ta_info {@target}">
            <h2>Tema:</h2> 
            <xsl:apply-templates select="@target" mode="info-card"/>
        </div>
    </xsl:template>
        

    <xsl:template match="tei:ref/@target" mode="info-card"> 
        <xsl:value-of select="translate(.,'#', '')"/>
    </xsl:template>
    
   
   
    


    <!--Trasformo xml in html e poi darò forma al css-->
    
    <!-- Template principale: parte dalla radice del documento -->
    <xsl:template match="/"> <!--Individuo i nodi con match (qui radice)-->
        <html lang="it">
            <head>
                <title><xsl:value-of select="//tei:title[1]"/></title> 
                
                <!--ora-->
                 <xsl:if test="tei:head[@type=subtitle]">
                    <h2><xsl:value-of select="//tei:head[@type=subtitle[1]]"/></h2>
                 </xsl:if>
                <!---->

                <link rel="stylesheet" href="CSS_B.css"/>
            </head>
            <body>
                <!--<title class="title"><xsl:value-of select="//tei:title[@xml:id='titolo_libro']"/></title>-->
                <p class="autore"><xsl:value-of select="//tei:author[@xml:id='nimpha']"/></p>
                
                
                
                <div class="edition-layout">
                    <xsl:apply-templates select="//tei:surface"/>
                    <div class="text-pane">
                        <xsl:apply-templates select="//tei:body"/>
                    </div>   

                    <!--Info-->
                    <div class="info_p" id="person-data">
                        <xsl:apply-templates select="$persons" mode="info-card"/>
                        <xsl:apply-templates select="$places" mode="info-card"/>
                        <xsl:apply-templates select="$works" mode="info-card"/>
                        <xsl:apply-templates select="$organizations" mode="info-card"/>
                        <xsl:apply-templates select="$terms" mode="info-card"/>
                        <xsl:apply-templates select="$themes" mode="info-card"/>
                        <details onclick="Show(this)">
                            <summary>Legenda</summary>
                            <p>              </p>
                            <img src="legenda.png" alt="Legenda" height="400"></img> 
                        </details>
                    </div>
                    <!--Info--> 

                </div>
                
                
                
                
                <script src="Lente.js"></script>
                <script src="Collega_testo_img.js"></script>
                <script src="Box_entita.js"></script>
                
                <footer><xsl:text>Martina Ricci e Beatrice Longhi
                - Cdt 2026</xsl:text></footer>
            </body>
        </html>
    </xsl:template>
    
    <!--
         java -jar saxon-he-10.9.jar -s:COMUNE_Farfalla_1877_4_8_AMilano.xml -xsl:FoglioStile.xsl -o:risultato1.html
         gaiaborghi@MacBook-Air-di-Gaia-10 Codifica % risultato1.html-->
    
    <xsl:template match="tei:head[@xml:id='titolo_head']">
        <h1 class="head"> <!--h2rend="{tei:title/@rend}"-->
            <xsl:attribute name="id">
            <xsl:if test="@rend='uppercase'">uppercase1</xsl:if>
            </xsl:attribute>
            <xsl:apply-templates/></h1>
    </xsl:template>

    <xsl:template match="tei:head[@xml:id='sottotitolo_head']">
        <h2 class="sub_head" > <!--rend="{tei:subtitle/@rend}"-->
            <xsl:attribute name="id">
            <xsl:if test="@rend='uppercase'">uppercase2</xsl:if>
            </xsl:attribute>
            <xsl:apply-templates/></h2>
    </xsl:template>

    
    
    
    <!-- Template per i nomi di luogo -->
    <xsl:template match="tei:placeName">
        <span class="luogo"
              onclick="mostraMarrone(this); mostraInfo('{substring-after(@ref,'#')}')"
              ondblclick="mostraInfo_dbcl('{substring-after(@ref,'#')}')">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:title[@ref]">
        <span class="opera"
              onclick="mostraArancione(this); mostraInfo('{substring-after(@ref,'#')}')"
              ondblclick="mostraInfo_dbcl('{substring-after(@ref,'#')}')">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:name[@type='publisher']">
        <span class="organizzazione"
              onclick="mostraVerde(this); mostraInfo('{substring-after(@ref,'#')}')"
              ondblclick="mostraInfo_dbcl('{substring-after(@ref,'#')}')">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:ref[@target]">
        <span class="tema"
              onmouseover="mostraCeleste(this)"
              onmouseout="noCeleste(this)"
              onclick="mostraTa('{@target}')"
              ondblclick="mostraTa_dbcl('{@target}')">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!--Template per le stelle-->
    
    <xsl:template match="tei:metamark[starts-with(@xml:id,'stella')]/text()"/> <!--Template vuoto per eliminare *-->
    
    
    
    
    <xsl:template match="tei:metamark[@xml:id='stella1']">
        <div class="stella"><span class="text-line"><xsl:apply-templates/><xsl:text>&#9733;</xsl:text></span></div>
    </xsl:template> <!--id="text-st1" in tutti con numeri-->
    
    
    <xsl:template match="tei:metamark[@xml:id='stella2']">
        <div class="stella"><span class="text-line"><xsl:apply-templates/><xsl:text>&#9733;</xsl:text></span></div>
    </xsl:template>
    


    <xsl:template match="tei:metamark[@xml:id='stella3']">
        <div class="stella"><span class="text-line"><xsl:apply-templates/><xsl:text>&#9733;</xsl:text></span></div>
    </xsl:template>
    
   

    <xsl:template match="tei:metamark[@xml:id='stella4']">
        <div class="stella"><span class="text-line"><xsl:apply-templates/><xsl:text>&#9733;</xsl:text></span></div>
    </xsl:template>
    
    
    
    <xsl:template match="tei:metamark[@xml:id='stella5']">
        <div class="stella"><span class="text-line"><xsl:apply-templates/><xsl:text>&#9733;</xsl:text></span></div>
    </xsl:template>
    
    
    
    <xsl:template match="tei:metamark[.='-']">
        <span class="trattino"><xsl:apply-templates/></span> 
    </xsl:template>
    
    
    <!--farfalle-->

    <xsl:template match="tei:metamark[starts-with(@xml:id,'far')]/text()"/>
    
    <xsl:template match="tei:metamark[@xml:id='far1']">
        <div><span id="text-far1f" class="text-line"><img src="farfallina.png"  alt="Farfalla" height="25"></img></span></div>
    </xsl:template>
    
    <xsl:template match="tei:metamark[@xml:id='far2']">
        <div><span id="text-far2f" class="text-line"><img src="farfallina.png" alt="Farfalla" height="25"></img></span></div>
    </xsl:template>
    
    
    
    
    
    
    
    <xsl:template match="tei:name">
        <span class="resp">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    
    <xsl:template match="tei:unclear">
        <span class="unclear" > <!--resp="{tei:unclear/@resp}" cert="{tei:unclear/@cert}"-->
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:distinct">
        <span class="distinct">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:emph">
        <span class="distinct" > <!--rend="{tei:emph/@rend}"-->
            <xsl:attribute name="class">
                <xsl:if test="@rend='italic'">italic</xsl:if>
            </xsl:attribute>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    
    <xsl:template match="tei:rs">
        <span class="rs {@type} {@subtype}" > <!--type="{tei:rs/@type}" subtype="{tei:rs/@subtype}"-->
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    
    <xsl:template match="tei:w">
        <span class="w" > <!--lemma="{tei:w/@lemma}"-->
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:q">
        <span class="q"> <!--<span class="q" type="{tei:q/@type}">-->
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:foreign">
        <span class="foreign" xml:lang="{tei:foreign/@xml:lang}" lang="{tei:foreign/@xml:lang}"> <!--{tei:foreign/@xml:lang} rend="{tei:foreign/@rend}"-->
           <xsl:attribute name="class">
            <xsl:if test="@rend='italic'">italic</xsl:if>
            </xsl:attribute>
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!--In css .stella{}-->
    <xsl:template match="tei:abbr">
        <span class="abbr"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="tei:expan">
        <span class="expan"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="tei:choice">
        <span class="choice"><xsl:apply-templates/></span>
    </xsl:template>
    
    <!--Per coincidenza righe testo (CONTROLLA)-->
    <xsl:template match="tei:surface">
        <div class="viewer-pane" >
            <button id="mode-toggle" type="button">🔍</button>
            <div id="image-zoomer-box">
            <img id="img-1" alt="Pagina sorgente del testo codificato" src="{tei:graphic/@url}"/>
            <svg class="overlay" viewBox="0 0 {substring-before(tei:graphic/@width,'px')} {substring-before(tei:graphic/@height,'px')}">
                    <xsl:apply-templates select=".//tei:zone[not(tei:zone)]" mode="overlay"/>
            </svg>
            <!--Magnifier-->
            <div id="img-2" style="background-image: url('{tei:graphic/@url}');"></div>
            <!--Magnifier-->
            </div>
        </div>
        
        
    </xsl:template>
    
   


    <xsl:template match="tei:zone" mode="overlay">
        <rect id="line-{@xml:id}" class="line-overlay"
              x="{@ulx}" y="{@uly}"
              width="{@lrx - @ulx}" height="{@lry - @uly}"/>
    </xsl:template>
   
  
    <!--Fine righe testo-->
    
    
    
    <xsl:template match="tei:lb">
        <xsl:if test="not(function='sectionDivider')">
        <span id="text-{substring-after(@facs,'#')}" class="text-line-marker"></span>
        </xsl:if>
    </xsl:template>
    
        
    
    
    <xsl:template match="tei:p">
        <p>
            <xsl:attribute name="class">
                <xsl:if test="@xml:id='p0'">numero_pagina</xsl:if>
                <xsl:if test="@rend='first-line-indented'">first-zone-indented</xsl:if>
                
            </xsl:attribute>
            <xsl:for-each-group select="node()" group-starting-with="tei:lb">
                <span id="text-{substring-after(current-group()[1]/@facs,'#')}" class="text-line">
                    <xsl:apply-templates select="current-group()[position() > 1]"/>
                </span>
                <br/>
            </xsl:for-each-group>
        </p>
    </xsl:template>
    
    
    
    
    
    
    <!--New-->
    
    <!-- Template per i nomi di persona -->
    
    <xsl:template match="tei:persName">
        <span class="persona"
              onclick="mostraRosa(this); mostraInfo('{substring-after(@ref,'#')}')"
              ondblclick="mostraInfo_dbcl('{substring-after(@ref,'#')}')">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!---->
    
    <xsl:template match="tei:term[@type='verbum']">
        <span class="verismo"
                     onmouseover="mostraViola(this)"
                     onclick="mostraSub('{@subtype}')"
                     ondblclick="mostraSub_dbcl('{@subtype}')"> 
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    
    <xsl:template match="tei:term[@type='stile']">
        <span class="lessico"
                     onmouseover="mostraBlu(this)"
                     onclick="mostraSub('{@subtype}')"
                     ondblclick="mostraSub_dbcl('{@subtype}')"> 
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:term[@type='forma_letteraria']">
        <span class="forma_letteraria"
                     onmouseover="mostraRosso(this)"
                     onclick="mostraSub('{@subtype}')"
                     ondblclick="mostraSub_dbcl('{@subtype}')"> 
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!---->
    
    
    
    <xsl:template match="tei:note" mode="info-card">
        <p><xsl:apply-templates mode="info-card"/></p>
    </xsl:template>
    
    <xsl:template match="tei:p" mode="info-card">
        <p><xsl:apply-templates mode="info-card"/></p>
    </xsl:template>
    
    
    <xsl:template match="tei:imprint" mode="info-card">
        <p>
            <xsl:value-of select="tei:publisher"/><xsl:text>, </xsl:text>
            <xsl:value-of select="tei:pubPlace"/><xsl:text>, </xsl:text>
            <xsl:value-of select="tei:date"/>
        </p>
    </xsl:template>
    
    
    <xsl:template match="tei:name[@type='epithet']">
        <span class="epiteto"><xsl:apply-templates/></span>
    </xsl:template>
    <!--New-->
    
    
    
    
    
    

</xsl:stylesheet>
