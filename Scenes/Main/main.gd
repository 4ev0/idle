extends Node2D
class_name Main

func _enter_tree() -> void:
	G.set("tree", get_tree())
	print("started")
	G.nodes["main"] = self
	
func _ready() -> void:
	G.window = get_window()
	G.main_ready.emit()
