@icon("res://Icons/node/icon_bullet.png")
extends Node

const colpo = preload("res://Objects/colpo.tscn")

@onready var cavalieri: Node = $"../GeneratoreDiCavalieri/Cavalieri"
@onready var input: LineEdit = $"../Control/Input"
@onready var testo_vis: Label = $"../Control/TestoVis"




func _process(delta: float) -> void:
	var cavalieriPresenti = cavalieri.get_children()
	for i in range(len(cavalieriPresenti)):
		if input.text == str(cavalieriPresenti[i].risultato) && !cavalieriPresenti[i].indovinato:
			cavalieriPresenti[i].indovinato = true
			instanziaProiettile(cavalieriPresenti[i])
			$"../Control".resetInput()



func instanziaProiettile(nemico: CharacterBody2D):
		var colpoINST = colpo.instantiate()
		colpoINST.position = %Bersaglio.position
		colpoINST.direzione = nemico.position
		colpoINST.bersaglio = nemico
		get_parent().add_child(colpoINST)
