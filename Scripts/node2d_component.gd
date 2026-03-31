extends Node2D
class_name Node2DComponent

var parent: Node

func _enter_tree() -> void:
	parent = get_parent()
	var vars: String = name.to_snake_case()
	parent.set(vars, self)
	print("%s -> %s = %s" %[parent.name, vars, parent.get(name.to_snake_case())])
		
