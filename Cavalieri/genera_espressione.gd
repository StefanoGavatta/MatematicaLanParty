extends Node
var difficolta: int = randi_range(1,3)

@export var numeroMin: int = 1
@export var numeroMax: int = 15
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
	numeri.append(randi_range(numeroMin,numeroMax))
	return numeri

func calcolatore(numeri:Array):
	print(numeri)
	get_parent().risultato = verificaRisultato(trovaX(numeri))
	print(get_parent().risultato)
	queue_free()

func verificaRisultato(risultato):
	# Se il risultato è un float, rigenera l'espressione
	if typeof(risultato) == TYPE_FLOAT:
		var nuoviNumeri = AssemblaNumero(selezionaNumeri(difficolta))
		return verificaRisultato(trovaX(nuoviNumeri))
	# Se il risultato è un intero, arrotonda e restituisci
	return int(risultato)

func trovaX(numeri:Array):

	var calcolati = numeri.duplicate()
	

	while "*" in calcolati or "/" in calcolati:
		if "*" in calcolati:
			var indice = calcolati.find("*")
			if indice > 0 and indice < calcolati.size() - 1:
				var numero = calcolati[indice-1] * calcolati[indice+1]
				calcolati.remove_at(indice+1)
				calcolati.remove_at(indice)
				calcolati.remove_at(indice-1)
				calcolati.insert(indice-1, numero)
			else:
				break
		
		elif "/" in calcolati:
			var indice = calcolati.find("/")
			if indice > 0 and indice < calcolati.size() - 1:
				var numero = calcolati[indice-1] / calcolati[indice+1]
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
