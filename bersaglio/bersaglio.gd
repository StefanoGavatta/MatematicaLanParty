extends Area2D

@export var vita: int = 100

@onready var progress_bar: ProgressBar = $ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


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
	body.distruggiAsteroide()
	Esplodi()
