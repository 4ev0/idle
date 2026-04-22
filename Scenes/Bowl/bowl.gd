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
		
var max_weight: int = 500:
	set(v):
		if max_weight == v:
			return
			
		max_weight = v
		max_weight_changed.emit(max_weight)
		
var weight: int = 500:
	set(v):
		v = min(v, max_weight)
		if weight == v:
			return
			
		if v > weight || v == 0:
			mix_v = 0
			if !_bowl_picked:
				controller.check_mixed()
			
		weight = v
		weight_changed.emit(weight)
	
var _bowl_picked: bool = false
var _in_drop_spot: bool = false:
	set(v):
		_in_drop_spot = v
		if !_in_drop_spot:
			angle = 0
			
var angle: float = 0

signal weight_changed(v: int)
signal max_weight_changed(v: int)
signal mix_value_changed(v: int)
signal mixed
signal spoon_entered
signal spoon_exited
signal bowl_picked
signal bowl_placed

func _enter_tree() -> void:
	CircleController.bowl = self

func _ready() -> void:
	await G.main_ready
	weight_changed.emit(weight)
	max_weight_changed.emit(max_weight)

func add_mix() -> void:
	mix_v += mix_step

func is_picked() -> bool:
	return _bowl_picked

func in_drop_spot() -> bool:
	return _in_drop_spot

func register_drop_spot(center_pos: Vector2, width: float) -> void:
	controller.ds_center_pos = center_pos
	controller.ds_half_width = width / 2
