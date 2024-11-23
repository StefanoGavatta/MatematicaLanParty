@icon("res://Icons/node_2D/icon_flag.png")
extends Area2D

@export var vita: int = 100

@onready var progress_bar: ProgressBar = $ProgressBar

func prendiDanno(danno:int):
	vita -= danno
	progress_bar.value = vita

func sparaRazzo(Asteroide: Vector2):
	print("sparato razzo direzione"+str(Asteroide))
	
func Esplodi():
	if vita <= 0:
		print("sconfitta")


func _on_body_entered(body: Node2D) -> void:
	prendiDanno(body.danno)
	body.distruggiCavaliere
	Esplodi()
