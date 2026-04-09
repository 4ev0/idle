extends Node2D
class_name Circle

var type: CircleManager.CircleTypes
@export var radius: int = 8
@export var randomize_color: bool = false
@onready var graphics: CircleGraphics
@onready var controller: CircleController
@export var data: CircleData = load("uid://q2qh1h13hc5u")
@onready var value: int = data.hp:
	set(v):
		value = max(0, v)
		if value <= 0 && controller:
			controller.die()

		value_updated.emit(value)
		
@onready var spawn_offset : float = 80

signal sliced(mouse_pos: Vector2)
signal spawned
signal respawn_requested
signal value_updated(new_v: float)
signal died


func get_target_scale() -> Vector2:
	if graphics:
		return Vector2.ONE * radius * 2 / graphics.texture_scale
	else:
		print("%s graphics == null" %name)
		return Vector2.ONE * radius * 2 / Vector2(100, 100)
		
