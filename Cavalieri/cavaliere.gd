extends CharacterBody2D

var Espressione
var velocità: int = 100
var grandezza: Vector2
var danno: int = 10
var risultato: int

@onready var bersaglio:Area2D = get_parent().get_node("%Bersaglio")
var target

func _ready() -> void:
	target = bersaglio.position

func _physics_process(delta: float) -> void:
	velocity = position.direction_to(target) * velocità
	move_and_slide()

#metodo chiamato per eliminare l'asteroide sia se hitta che se viene indovinato
#si auto rimuove dall'array non lasciandio traccia
func distruggiAsteroide(): 
	get_parent().asteroidi.erase(self)
	queue_free()