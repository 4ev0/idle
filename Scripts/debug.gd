extends Node
class_name Debug

enum CircleTypes {
	NULL,
	WHITE,
	RED }
@export var start_circles: Dictionary[CircleTypes, int]
@export var cash: int = 0:
	set(v):
		cash = v
		G.cash = cash
@export var print_writing: bool = false

@export_category("merge debug")
@export var merge_type: CircleTypes
@export var merge: bool = false:
	set(v):
		merge = v
		if v && merge_type && merge_type != CircleTypes.NULL:
			var ck: CircleContainer = G.get_n("circle_container")
			if ck:
				ck.merge_circles(merge_type)
				

func _enter_tree() -> void:
	G.nodes.debug = self

func _ready() -> void:
	await owner.ready
	G.cash = cash
	var ck: CircleContainer = G.get_n("circle_container")
	if ck:
		for i in start_circles:
			var v: int = start_circles[i]
			if v <= 0:
				continue
			for c in range(v):
				ck.add_circle(i)

func write(text: String) -> void:
	if !print_writing:
		return
	
	print(text)
