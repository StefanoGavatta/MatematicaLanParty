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

@onready var nav: NavigationAgent2D = $NavigationAgent2D

func _ready() -> void:
	
	assegnaValori()
	target = bersaglio.position
	
	
func _physics_process(delta: float) -> void:

	# Add the gravity
	var direction = Vector3()
	nav.target_position = bersaglio.global_position
	# Wait for map synchronization
	#var timer = get_tree().create_timer(0.1, true)
	#await timer.timeout
	
	
	
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * velocità, 8 * delta)
	
	move_and_slide()
	
	#velocity = position.direction_to(target) * velocità
	#move_and_slide()

#metodo chiamato per eliminare l'asteroide sia se hitta che se viene indovinato
func distruggiCavaliere():
	$Espressione.visible = false
	$Risultato.visible = false
	set_physics_process(false)
	$AnimatedSprite2D.play("death")
	await $AnimatedSprite2D.animation_finished
	queue_free()

#in base alla difficoltà decide se andare + lento 
func assegnaValori():
	match difficolta:
		1:
			velocità = 100
		2:
			velocità = 60
		3: 
			velocità = 30
	

#func indovinatoMet():
	#indovinato = true
	#await get_tree().create_timer(4).timeout
	#queue_free()
