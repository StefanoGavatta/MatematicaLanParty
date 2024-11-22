extends Node
var difficolta: int = randi_range(1,3)

@onready var espressione: Label = $"../Espressione"
@onready var risultato: Label = $"../Risultato"

@export var numeroMin: int = 1
@export var numeroMax: int = 12

func _ready() -> void:
	get_parent().difficolta = difficolta
	calcolatore(AssemblaNumero(selezionaNumeri(difficolta)))

func selezionaNumeri(difficolta: int)->Array:
	var numeri = []
	for i in range(difficolta):
		numeri.append(randi_range(numeroMin,numeroMax))
	return numeri

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
	
	numeri.append(randi_range(numeroMin,numeroMax))
	return numeri

func calcolatore(numeri:Array):
	get_parent().risultato = verificaRisultato(trovaX(numeri))
	
	if nuoviNumeri != null:
		for i in len(nuoviNumeri):
			espressione.text += str(nuoviNumeri[i])
	else:
		for i in len(numeri):
			espressione.text += str(numeri[i])
			
	risultato.text = str(get_parent().risultato)
	
	queue_free()


var nuoviNumeri= null
func verificaRisultato(risultato):

	# Ensure result is a positive integer
	if typeof(risultato) == TYPE_FLOAT or risultato is float or risultato < 1:
		nuoviNumeri = AssemblaNumero(selezionaNumeri(difficolta))
		return verificaRisultato(trovaX(nuoviNumeri))
		
	# Convert to integer to remove any potential floating point imprecision
	return int(risultato)



func trovaX(numeri:Array):
	var calcolati = numeri.duplicate()
	
	# Handle division carefully to avoid floats
	while "/" in calcolati:
		var indice = calcolati.find("/")
		if indice > 0 and indice < calcolati.size() - 1:
			# Ensure division results in a whole number
			var divisore = calcolati[indice+1]
			var dividendo = calcolati[indice-1]
			
			# If division doesn't result in a whole number, regenerate
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
