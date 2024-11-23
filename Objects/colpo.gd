@icon("res://Icons/node_2D/icon_bullet.png")
extends CharacterBody2D

var velocita = 600
var direzione: Vector2 = Vector2(0,0)
var bersaglio: CharacterBody2D

func _process(delta: float) -> void:
	velocity = velocita * position.direction_to(direzione)
	
	# Update rotation based on velocity direction
	if velocity.length() > 0:
		rotation = velocity.angle() + deg_to_rad(90)  # Add 90 degrees if you want to point upwards
	
	move_and_slide()

func _on_auto_distruzione_timeout() -> void:
	distruzione()

func distruzione():
	queue_free()

func _on_radar_body_entered(body: Node2D) -> void:
	if body == bersaglio:
		body.distruggiCavaliere()
		distruzione()
