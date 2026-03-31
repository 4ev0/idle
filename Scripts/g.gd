extends Node

var nodes: Dictionary = {}
var strength: float = 10
var cash: int = 0:
	set(v):
		cash = v
		cash_updated.emit(cash)

signal cash_updated(v: int)

func _input(event: InputEvent) -> void:
	if event is InputEventKey && event.is_pressed():
		match event.keycode:
			KEY_R:
				get_tree().reload_current_scene()
			KEY_ESCAPE:
				get_tree().quit()
