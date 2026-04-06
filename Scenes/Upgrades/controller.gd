extends Node2D
class_name UpgradeController

var closest_occupired_cell_coords: Vector2
var parent: Upgrade
@onready var grid: Grid = G.get_n("grid")
var target_coords: Vector2i:
	set(v):
		if target_coords != v:
			target_coords = v
			if target_coords != Vector2i(-1,-1):
				if grid:
					target_pos = grid.get_cell_center(target_coords)
					parent.target_coords_changed.emit(target_pos)
var target_pos: Vector2
		
var knife_scene: PackedScene = load("uid://bvcwhnhmhn2c4")
		
func _ready() -> void:
	var gp: Circle = parent.parent
	if grid:
		target_coords = grid.get_closest_circle(grid.get_cell_coords(gp.global_position))

	gp.died.connect(_on_circle_died)
	
func _on_circle_died() -> void:
	var k: Knife = knife_scene.instantiate()
	k.dir = parent.global_position.direction_to(target_pos)
	k.global_position = parent.global_position
	G.get_n("main").add_child(k)
	pass
