extends Node2D
class_name Knife

var dir: Vector2

func _ready() -> void:
	if !dir:
		queue_free()
		
func _physics_process(delta: float) -> void:
	global_position += dir * 10 * delta
