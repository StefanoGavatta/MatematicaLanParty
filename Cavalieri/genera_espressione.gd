extends Node

var difficolta: int = randi_range(1,3)


func _ready() -> void:
	calcolatore(AssemblaNumero(selezionaNumeri(difficolta)))
func selezionaNumeri(difficolta: int)->Array:
	var numeri = []
	for i in range(difficolta):
		numeri.append(randi_range(1,56))
	return numeri

func AssemblaNumero(numeri:Array):
	var positions = -1
	var simboli = ["+","-","*","/"]
	for i in range(difficolta):
		if positions < len(numeri):
			positions += 2
			numeri.insert(positions,simboli.pick_random())
	numeri.append(randi_range(1,56))
	return numeri

func calcolatore(numeri:Array):
	pass
