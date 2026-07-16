from lxml import etree

# 1. Definisci il nome ESATTO del file schema (con le virgolette e l'estensione .rng)
file_relaxng = "tei_all.rng" 
lista_file_xml = ["Farfalla_1877_4_4_Ilrealismonellarte.xml", "Farfalla_1877_4_8_Pompei.xml", "Farfalla_1877_4_8_AMilano.xml", "Farfalla_1877_3_5_Bibliografia.xml"]

def valida_relaxng_multiplo():
    print("--- INIZIO VALIDAZIONE RELAX NG MULTIPLA ---")
    try:
        # 2. Usa la variabile file_relaxng definita sopra
        relaxng_doc = etree.parse(file_relaxng)
        relaxng_validator = etree.RelaxNG(relaxng_doc)
        
        # 3. Cicla attraverso ogni file nella lista
        for file_xml in lista_file_xml:
            print(f"\nSto controllando: {file_xml} ...")
            try:
                xml_doc = etree.parse(file_xml)
                
                if relaxng_validator.validate(xml_doc):
                    print("✅ Valido!")
                else:
                    print("❌ NON valido. Errori riscontrati:")
                    for error in relaxng_validator.error_log:
                        print(f"   - Linea {error.line}: {error.message}")
            
            except Exception as e:
                print(f"⚠️ Impossibile leggere il file {file_xml}. Errore: {e}")
                
    except Exception as e:
        print(f"Si è verificato un errore critico con lo schema: {e}")

if __name__ == "__main__":
    valida_relaxng_multiplo()