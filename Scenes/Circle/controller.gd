extends Node2D
class_name CircleController

var parent: Circle
var mouse_in: bool = false
var hit_ready: bool = true
var ss: int = 0

var sliceable: Sliceable

func _ready() -> void:
	if sliceable:
		sliceable.sliced.connect(_on_sliced)
		sliceable.set_collision_radius(parent.radius)
	
func _on_sliced() -> void:
	ss += 1
	parent.value -= G.strength - parent.data.durability
