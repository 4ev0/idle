extends Node
class_name Debug

@export var cash: int = 0:
	set(v):
		cash = v
		G.cash = cash

func _ready() -> void:
	await owner.ready
	G.cash = cash
