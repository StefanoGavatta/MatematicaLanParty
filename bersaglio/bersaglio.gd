@icon("res://Icons/node_2D/icon_flag.png")
extends Area2D

@export var vita: int = 100

@onready var progress_bar: ProgressBar = $ProgressBar

func prendiDanno(danno:int):
	vita -= danno
	progress_bar.value = vita

func Esplodi():
	if vita <= 0:
		pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("nemico"):
		prendiDanno(body.danno)
		body.queue_free()
		Esplodi()
