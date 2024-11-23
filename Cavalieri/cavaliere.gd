@icon("res://Icons/node_3D/icon_sword.png")
extends CharacterBody2D

var difficolta: int
var velocità: int = 100
var grandezza: Vector2
var danno: int = 10
var risultato: int

var indovinato: bool = false
@onready var bersaglio:Area2D = get_parent().get_node("%Bersaglio")
var target

func _ready() -> void:
	
	assegnaValori()
	target = bersaglio.position

func _physics_process(delta: float) -> void:
	velocity = position.direction_to(target) * velocità
	move_and_slide()

#metodo chiamato per eliminare l'asteroide sia se hitta che se viene indovinato
#si auto rimuove dall'array non lasciandio traccia
func distruggiCavaliere(): 
	queue_free()

func assegnaValori():
	match difficolta:
		1:
			velocità = 100
		2:
			velocità = 60
		3: 
			velocità = 30
	
