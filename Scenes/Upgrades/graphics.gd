extends Node2D
class_name UpgradeGraphics

var parent: Upgrade
@onready var knife: Sprite2D = $Knife

func _ready() -> void:
	parent.target_coords_changed.connect(_on_target_coords_changed)
	
func _on_target_coords_changed(coords: Vector2i) -> void:
	var grid: Grid = G.get_n("grid")
	if grid:
		look_at(grid.get_cell_center(coords))
		knife.look_at(grid.get_cell_center(coords))
