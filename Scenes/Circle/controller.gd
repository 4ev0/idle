extends Node2D
class_name CircleController

var parent: Circle
@onready var button: Button = $Button
var mouse_in: bool = false
var hit_ready: bool = true
@onready var timer: Timer = $Timer

var sliceable: Sliceable

func _ready() -> void:
	if parent:
		button.scale = parent.get_target_scale()
	
	if sliceable:
		sliceable.sliced.connect(_on_sliced)
		sliceable.set_collision_radius(parent.radius)
	
func _on_sliced() -> void:
	hit()
#
func hit() -> void:
	parent.value -= G.strength - parent.data.durability
#
#func _on_mouse_entered() -> void:
	#hit()
#
#func _on_mouse_exited() -> void:
	#mouse_in = false
#
#func _on_cooldown_timeout() -> void:
	#if mouse_in:
		#hit()
#
#func check_intersection() -> void:
	#mouse_in = button.get_rect().has_point(get_local_mouse_position())
