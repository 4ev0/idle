extends Node2D
class_name Circle

@onready var graphics: CircleGraphics
@onready var controller: CircleController
var type: CircleManager.CircleTypes
@export var radius: int = 8
@export var randomize_color: bool = false
@export var data: CircleData = load("uid://q2qh1h13hc5u")
@onready var value: int = data.hp:
	set(v):
		value = max(0, v)
		if value <= 0 && controller:
			controller.die()

		value_updated.emit(value)
		
@onready var spawn_offset : float = 80
var slice_stage: int = 0
var frame_count: int = 2
var frame: int = 0:
	set(v):
		if v == frame:
			return
		
		frame = v
		frame_updated.emit(frame)

signal sliced(mouse_pos: Vector2)
signal spawned
signal respawn_requested
signal value_updated(new_v: float)
signal died
signal frame_updated(_frame: int)

func get_target_scale() -> Vector2:
	if graphics:
		return Vector2.ONE * radius * 2 / graphics.texture_scale
	else:
		print("%s graphics == null" %name)
		return Vector2.ONE * radius * 2 / Vector2(100, 100)
		
