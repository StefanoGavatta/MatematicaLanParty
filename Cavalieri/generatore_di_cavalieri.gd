extends Node

const meteora = preload("res://Cavalieri/cavaliere.tscn")
@onready var timer: Timer = $Timer

var asteroidi = []

func selezioneWaitTime():
	timer.wait_time = randi_range(1,2)

func selezionaPosizione() -> Vector2:
	return Vector2(randi_range(0,1168),0)
	

func summonMeteorite():
	var asteroideinst = meteora.instantiate()
	asteroideinst.position = selezionaPosizione()
	add_child(asteroideinst)
	asteroidi.append(asteroideinst)



func _on_timer_timeout() -> void:
	summonMeteorite()
	selezioneWaitTime()
