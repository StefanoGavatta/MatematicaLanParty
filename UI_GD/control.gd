@icon("res://Icons/control/icon_text_panel.png")
extends Control

@onready var input: LineEdit = $Input
@onready var testo_vis: Label = $SkinInput

func _ready() -> void:
	input.grab_focus()
	input.focus_exited.connect(_on_focus_exited)
	input.virtual_keyboard_type = LineEdit.KEYBOARD_TYPE_NUMBER
	input.text_changed.connect(_on_input_text_changed)
	
func _on_input_text_changed(new_text: String) -> void:
	var solo_numeri = ""
	for carattere in new_text:
		if carattere.is_valid_int():  
			solo_numeri += carattere
	input.set_text(solo_numeri)
	input.caret_column = solo_numeri.length()

func _on_focus_exited() -> void:
	input.grab_focus()
	
func _process(delta: float) -> void:
	aggiornaTesto()

func aggiornaTesto():
	testo_vis.text = input.text
	
func resetInput():
	input.text = ""
