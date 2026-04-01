extends Node
class_name Initializer

func _ready() -> void:
	var tree : SceneTree = get_tree()
	var nodes : Array = tree.get_nodes_in_group("g")
	for n in nodes:
		var formatted : String = n.name.to_snake_case()
		G.nodes[formatted] = n
		G.get_n("debug").write("G -> %s = %s" %[n, formatted])
