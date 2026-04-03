extends Node2D
class_name Circle

@export var radius: int = 8
@export var randomize_color: bool = false
@onready var graphics: CircleGraphics
@onready var controller: CircleController
@export var data: CircleData = load("uid://q2qh1h13hc5u")
@onready var value: int = data.hp:
	set(v):
		value = max(0, v)
		if value <= 0:
			die()

		value_updated.emit(value)
		
@onready var spawn_offset : float = 80
signal value_updated(new_v: float)

func _ready() -> void:
	spawn(Vector2.ZERO)

func spawn(pos: Vector2) -> void:
	var grid: Grid = G.get_n("grid")
	var target_cell_pos : Vector2 = grid.get_rand_free_cell()
	global_position = grid.get_cell_center(target_cell_pos)
	grid.occupy_cell(target_cell_pos)
	value = data.hp

func get_target_scale() -> Vector2:
	if graphics:
		return Vector2.ONE * radius * 2 / graphics.texture_scale
	else:
		print("%s graphics == null" %name)
		return Vector2.ONE * radius * 2 / Vector2(100, 100)
		
func die() -> void:
	G.cash += data.cost
	G.xp += data.xp
	G.get_n("grid").free_cell(global_position)
	spawn(Vector2(180, 90) + Vector2(randf_range(0, spawn_offset), randf_range(0, spawn_offset)))
