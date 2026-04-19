extends Node2D
class_name DropSpot

@onready var bowl: Bowl:
	get:
		if !bowl:
			bowl = get_parent().get_node("Bowl")

		return bowl

@onready var collision_shape: Shape2D = $Controller/Area2D/CollisionShape2D.shape

func _ready() -> void:
	bowl.register_drop_spot(global_position, collision_shape.size.x)
