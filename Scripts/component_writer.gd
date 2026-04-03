extends Node
class_name ComponentWriter

func _enter_tree() -> void:
	var parent: Node = get_parent()
	var gparent: Node = parent.get_parent()
	parent.set("parent", gparent) 
	var vars: String = parent.name.to_snake_case()
	gparent.set(vars, parent)
	if G.nodes.has("debug"):
		G.get_n("debug").write("%s -> %s = %s" %[gparent.name, vars, gparent.get(vars)])
	
	queue_free()
