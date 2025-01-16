def verifica_espressioni(file_path):
    with open(file_path, 'r') as file:
        righe = file.readlines()

    righe_errate = []

    for numero_riga, riga in enumerate(righe, start=1):
        try:
            # Separazione dell'espressione e del risultato dichiarato
            espressione, risultato_dichiarato = riga.strip().split('=')
            espressione = espressione.strip()
            risultato_dichiarato = int(risultato_dichiarato.strip())

            # Calcolo del risultato effettivo
            risultato_effettivo = eval(espressione) 

            # Confronto
            if risultato_effettivo != risultato_dichiarato:
                righe_errate.append((numero_riga, espressione, risultato_effettivo, risultato_dichiarato))
        except Exception as e:
            # Gestione di eventuali errori nel parsing o calcolo
            righe_errate.append((numero_riga, riga.strip(), "Errore", str(e)))

    if righe_errate:
        print("Errori trovati:")
        for errore in righe_errate:
            print(f"Riga {errore[0]}: {errore[1]} | Calcolato: {errore[2]}, Dichiarato: {errore[3]}")
    else:
        print("Tutte le espressioni sono corrette.")

# Esempio di utilizzo
file_path = 'operazioni.txt'  # Cambia il percorso al file corretto
verifica_espressioni(file_path)
