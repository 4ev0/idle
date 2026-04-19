extends Node
class_name SaladManager

@onready var circle_manager: CircleManager = G.get_n("circle_manager")
var target_weight: float = 1:
	set(v):
		if v == target_weight:
			return
		
		target_weight = v
		weight = 0
		reached = false
		target_changed.emit(target_weight)
		
var reached: bool = false
var weight: float = 0:
	set(v):
		if v == weight:
			return
			
		weight = v
		weight_changed.emit(weight)
		if weight >= target_weight && !reached:
			enough_weight.emit()
			reached = true

signal enough_weight
signal weight_changed(v: float)
signal target_changed(v: float)

func _ready() -> void:
	circle_manager.circle_died.connect(_on_circle_died)
	await G.main_ready
	weight_changed.emit(weight)
	target_changed.emit(target_weight)
	
func _on_circle_died(type: CircleManager.CircleTypes) -> void:
	weight += 10

func is_enough_weight() -> bool:
	return weight >= target_weight
