extends Node2D
class_name DropSpot

var graphics: DropSpotGraphics
@onready var bowl: Bowl:
	get:
		if !bowl:
			bowl = get_parent().get_node("Bowl")

		return bowl

@onready var collision_shape: Shape2D = $Controller/Area2D/CollisionShape2D.shape
var target_weight: int = 100
var weight: int = 0:
	set(v):
		v = max(0, v)
		if v == weight:
			return
		
		weight = v
		weight_updated.emit(weight)
		if weight == 0:
			G.salad_submitted.emit()
			graphics.play_quota_change_animation(target_weight)
			weight = target_weight
			
signal weight_updated(v: int)
signal change_animation_finished

func _ready() -> void:
	bowl.register_drop_spot(global_position, collision_shape.size.x)
	weight = target_weight
