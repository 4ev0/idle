extends Node2D
class_name Bowl

var controller: BowlController
@onready var bowl_left: float:
	get:
		return $BowlLeft.position.x
		
@onready var bowl_right: float:
	get:
		return $BowlRight.position.x

@export var target_mix: int = 100
@export var mix_step: int = 8
var mix_v: int = 0:
	set(v):
		if mix_v == target_mix && v != 0:
			return
			
		mix_v = min(v, target_mix)
		mix_value_changed.emit(mix_v)
		if mix_v == target_mix:
			mixed.emit()
			spoon_exited.emit()
		
var _bowl_picked: bool = false
var _in_drop_spot: bool = false:
	set(v):
		_in_drop_spot = v
		if !_in_drop_spot:
			angle = 0
			
var angle: float = 0
var weight_v: float = 0:
	set(v):
		if weight_v == 0 && v < weight_v:
			return
			
		weight_v = max(0, v)
		
		if weight_v == 0:
			mix_v = 0
			controller.salad_manager.salad_submitted.emit()

signal mix_value_changed(v: int)
signal mixed
signal spoon_entered
signal spoon_exited
signal bowl_picked
signal bowl_placed
signal salad_submitted

func add_mix() -> void:
	mix_v += mix_step

func is_picked() -> bool:
	return _bowl_picked

func in_drop_spot() -> bool:
	return _in_drop_spot

func register_drop_spot(center_pos: Vector2, width: float) -> void:
	controller.ds_center_pos = center_pos
	controller.ds_half_width = width / 2
