extends Node
class_name Debug

@export var start_circles: Dictionary[CircleManager.CircleTypes, int]
@export var cash: int = 0:
	set(v):
		cash = v
		G.cash = cash
@export var print_writing: bool = false
@export var xp: int = 0
@export var infinite_cash: bool = false
@export var complete_salad_goal: bool = false:
	set(v):
		complete_salad_goal = v
		if complete_salad_goal:
			var sm: SaladManager = G.get_n("salad_manager")
			if sm:
				sm.weight = sm.target_weight

@export_category("merge debug")
@export var merge_type: CircleManager.CircleTypes
@export var merge: bool = false:
	set(v):
		merge = v
		if v && merge_type && merge_type != CircleManager.CircleTypes.NULL:
			var ck: CircleContainer = G.get_n("circle_container")
			if ck:
				ck.merge_circles(merge_type)
				

func _enter_tree() -> void:
	G.nodes.debug = self

func _ready() -> void:
	await owner.ready
	complete_salad_goal = complete_salad_goal
	G.cash = cash
	G.set("xp", xp)
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
