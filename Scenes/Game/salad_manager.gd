extends Node
class_name SaladManager

@onready var camera: Camera = G.get_n("camera")

func _ready() -> void:
	G.salad_submitted.connect(_on_salad_submitted)
	
func _on_salad_submitted() -> void:
	camera.shake(10, 0.13)
