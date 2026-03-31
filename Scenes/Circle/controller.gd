extends Node2DComponent
class_name CircleController

@onready var button: Button = $Button
var mouse_in: bool = false
var hit_ready: bool = true
@onready var timer: Timer = $Timer

func _ready() -> void:
	if parent:
		button.scale = parent.get_target_scale()
	
	button.mouse_entered.connect(_on_mouse_entered)
	#button.mouse_exited.connect(_on_mouse_exited)
	#timer.timeout.connect(_on_cooldown_timeout)

func hit() -> void:
	#hit_ready = false
	parent.value -= G.strength - parent.data.durability
	#timer.start()

func _on_mouse_entered() -> void:
	#mouse_in = true
	hit()

func _on_mouse_exited() -> void:
	mouse_in = false

func _on_cooldown_timeout() -> void:
	if mouse_in:
		hit()

func check_intersection() -> void:
	mouse_in = button.get_rect().has_point(get_local_mouse_position())
