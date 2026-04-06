extends Node2D
class_name CircleController

var parent: Circle
var mouse_in: bool = false
var hit_ready: bool = true

var sliceable: Sliceable

func _ready() -> void:
	if sliceable:
		sliceable.sliced.connect(_on_sliced)
		sliceable.set_collision_radius(parent.radius)
	
	spawn()
	
func _on_sliced() -> void:
	parent.value -= G.strength - parent.data.durability
	parent.sliced.emit(get_global_mouse_position())

func spawn() -> void:
	var grid: Grid = G.get_n("grid")
	var target_cell_pos : Vector2 = grid.get_rand_free_cell()
	parent.global_position = grid.get_cell_center(target_cell_pos)
	grid.occupy_cell(target_cell_pos)
	parent.value = parent.data.hp
	parent.spawned.emit()

func die() -> void:
	G.cash += parent.data.cost
	G.xp += parent.data.xp
	G.get_n("grid").free_cell(global_position)
	parent.died.emit()
	spawn()
	
