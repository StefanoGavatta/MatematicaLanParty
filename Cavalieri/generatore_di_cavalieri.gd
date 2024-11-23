@icon("res://Icons/node/icon_character.png")
extends Node

const meteora = preload("res://Cavalieri/cavaliere.tscn")
@onready var timer: Timer = $Timer
@export var minSpawn: int = 1
@export var maxSpawn: int = 5

func selezioneWaitTime():#seleziona il tempo di spawn cavalieri 
	timer.wait_time = randi_range(minSpawn,maxSpawn)

func selezionaPosizione() -> Vector2:
	return Vector2(randi_range(0,1168),0)
	

func summonMeteorite():#istanzia e crea il nemico
	var asteroideinst = meteora.instantiate()
	asteroideinst.position = selezionaPosizione()
	$Cavalieri.add_child(asteroideinst)


func _on_timer_timeout() -> void:#summona e selezina il prossimo wait time
	summonMeteorite()
	selezioneWaitTime()
