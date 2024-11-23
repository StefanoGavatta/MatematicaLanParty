@icon("res://Icons/node/icon_parchment.png")

extends Node
#!!!!SCRIPT ALTAMENTE POCO EFFICIENTE!!!!


#lambda function per determinare la difficoltà in base alle probabilità
var difficolta = func():
	var numeroID = randi_range(1,10)
	if numeroID > 0 && numeroID <= 5:
		return 1
	elif numeroID > 5 && numeroID <= 8:
		return 2
	elif numeroID >= 9:
		return 3

@onready var espressione: Label = $"../Espressione"
@onready var risultato: Label = $"../Risultato"

@export var numeroMin: int = 1
@export var numeroMax: int = 12

#chiama la lambda function e affida il valore
func _ready() -> void:
	difficolta = difficolta.call()
	get_parent().difficolta = difficolta
	calcolatore(AssemblaNumero(selezionaNumeri(difficolta)))

#seleziona da 2 a 4 numeri e inserisce nell'array
func selezionaNumeri(difficolta: int)->Array:
	var numeri = []
	for i in range(difficolta):
		numeri.append(randi_range(numeroMin,numeroMax))
	return numeri

#inserisce in mezzo ai numeri uno tra i 4 simboli(* e /) possono esseree utilizzati solo una volta
func AssemblaNumero(numeri:Array):
	var positions = -1
	var simboli = ["+","-","*","/"]
	for i in range(difficolta):
		if positions < len(numeri):
			positions += 2
			numeri.insert(positions,simboli.pick_random())
			
			if "*" in numeri and simboli.has("*"):
				simboli.erase("*")
			if "/" in numeri and simboli.has("/"):
				simboli.erase("/")
	
	numeri.append(randi_range(numeroMin,numeroMax))#aggiunge l'ultimo numero
	return numeri

func calcolatore(numeri:Array):
	get_parent().risultato = verificaRisultato(trovaX(numeri))
	
	if nuoviNumeri != null:#se l'espressione è stata cambiata scriverà i nuovi valori
		for i in len(nuoviNumeri):
			espressione.text += str(nuoviNumeri[i])
	else: #altrimenti userà quella base
		for i in len(numeri): 
			espressione.text += str(numeri[i])
			
	risultato.text = str(get_parent().risultato) #!!!!!! debug !!!
	
	queue_free() #si autodistrugge perchè ormai inutile


var nuoviNumeri= null
func verificaRisultato(risultato):

	# si assicura che il valore sia intero
	if typeof(risultato) == TYPE_FLOAT or risultato is float or risultato < 1:
		nuoviNumeri = AssemblaNumero(selezionaNumeri(difficolta))
		return verificaRisultato(trovaX(nuoviNumeri))
		
	# converte in intero
	return int(risultato)



func trovaX(numeri:Array):
	var calcolati = numeri.duplicate()
	
	#ci assicuriamo che le divisioni non generi floats (unico operatore che può farlo)
	while "/" in calcolati:
		var indice = calcolati.find("/")
		if indice > 0 and indice < calcolati.size() - 1:
			# affidiamo divisore e dividendo
			var divisore = calcolati[indice+1]
			var dividendo = calcolati[indice-1]
			
			# se la divisione non 
			if dividendo % divisore != 0:
				return 0
			
			var numero = dividendo / divisore
			calcolati.remove_at(indice+1)
			calcolati.remove_at(indice)
			calcolati.remove_at(indice-1)
			calcolati.insert(indice-1, numero)
		else:
			break
	
	while "*" in calcolati:
		var indice = calcolati.find("*")
		if indice > 0 and indice < calcolati.size() - 1:
			var numero = calcolati[indice-1] * calcolati[indice+1]
			calcolati.remove_at(indice+1)
			calcolati.remove_at(indice)
			calcolati.remove_at(indice-1)
			calcolati.insert(indice-1, numero)
		else:
			break
	
	while "+" in calcolati or "-" in calcolati:
		if "+" in calcolati:
			var indice = calcolati.find("+")
			if indice > 0 and indice < calcolati.size() - 1:
				var numero = calcolati[indice-1] + calcolati[indice+1]
				calcolati.remove_at(indice+1)
				calcolati.remove_at(indice)
				calcolati.remove_at(indice-1)
				calcolati.insert(indice-1, numero)
			else:
				break
		
		elif "-" in calcolati:
			var indice = calcolati.find("-")
			if indice > 0 and indice < calcolati.size() - 1:
				var numero = calcolati[indice-1] - calcolati[indice+1]
				calcolati.remove_at(indice+1)
				calcolati.remove_at(indice)
				calcolati.remove_at(indice-1)
				calcolati.insert(indice-1, numero)
			else:
				break
	
	return calcolati[0] if calcolati.size() > 0 else 0
