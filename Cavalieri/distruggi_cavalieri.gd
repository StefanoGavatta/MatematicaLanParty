@icon("res://Icons/node/icon_bullet.png")
extends Node

@onready var cavalieri: Node = $"../GeneratoreDiCavalieri/Cavalieri"
@onready var input: LineEdit = $"../Control/Input"

func _process(delta: float) -> void:
	var cavalieriPresenti = cavalieri.get_children()
	for i in range(len(cavalieriPresenti)):
		if input.text == str(cavalieriPresenti[i].risultato):
			cavalieriPresenti[i].distruggiCavaliere()
			resetInput()

func resetInput():
	input.text = ""
