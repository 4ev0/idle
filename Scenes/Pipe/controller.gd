extends Node2D
class_name PipeController

var pickup: PickupComponent
var parent: Pipe

func _ready() -> void:
	pickup.sliced.connect(_on_sliced)

func _on_sliced() -> void:
	parent.lever_pulled.emit()
