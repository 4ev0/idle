extends Node2D
class_name Circle

@onready var controller: CircleController
var type: CircleManager.CircleTypes
@export var radius: int = 8
@export var data: CircleData = load("uid://q2qh1h13hc5u")
@onready var value: int = data.hp:
	set(v):
		value = max(0, v)
		if value <= 0 && controller:
			controller.die()

		value_updated.emit(value)
		
var target_pos: Vector2 = Vector2.ZERO
var frame_count: int = 2
var frame: int = 0:
	set(v):
		if v == frame:
			return
		
		frame = min(v, frame_count)
		frame_updated.emit(frame)

signal sliced(mouse_pos: Vector2)
signal spawned
signal respawn_requested
signal value_updated(new_v: float)
signal died
signal frame_updated(_frame: int)
