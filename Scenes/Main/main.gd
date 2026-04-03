extends Node2D
class_name Main

func _enter_tree() -> void:
	print("started")

func _ready() -> void:
	G.main_ready.emit()
