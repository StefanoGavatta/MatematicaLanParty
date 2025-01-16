@icon("res://Icons/node/icon_bullet.png")
extends Node

const colpo = preload("res://Objects/colpo.tscn")

@onready var cavalieri: Node = $"../GeneratoreDiCavalieri/Cavalieri"
@onready var input: LineEdit = $"../Input/Input"
@onready var testo_vis: Label = $"../Input/SkinInput"

#controlla ogni frame che nella casella input sia presente il valore corretto
func _process(delta: float) -> void:
	var cavalieriPresenti = cavalieri.get_children()
	for i in range(len(cavalieriPresenti)):
		if input.text == str(cavalieriPresenti[i].risultato) && !cavalieriPresenti[i].indovinato:
			cavalieriPresenti[i].indovinatoMet()
			cavalieriPresenti[i].velocità = cavalieriPresenti[i].velocità / 2
			istanziaProiettile(cavalieriPresenti[i])
			$"../Input".resetInput()

#!!DEBUG!!
var cavalieriDistrutti = 0

#crea il proiettile e gli da i valori
func istanziaProiettile(nemico: CharacterBody2D):
		var colpoINST = colpo.instantiate()
		colpoINST.position = %Bersaglio.position
		colpoINST.direzione = nemico.position
		colpoINST.bersaglio = nemico
		add_child(colpoINST)
		
		
		#!!RIMUOVERE DOPO DEBUG!!
		cavalieriDistrutti += 1
		$"../Punteggio".text = "Punteggio: "+str(cavalieriDistrutti)
