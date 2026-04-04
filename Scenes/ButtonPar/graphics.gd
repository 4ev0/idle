extends Control
class_name ButtonGraphics

var parent: ButtonPar

func _ready() -> void:
	if parent:
		parent.button_hitted.connect(_on_button_hitted)
		parent.button_accepted.connect(_on_button_accepted)

func _on_button_hitted(v: int) -> void:
	pass
	
func _on_button_accepted() -> void:
	pass
