extends Node2D
class_name Grid

var graphics: GridGraphics
@onready var reference_rect: ReferenceRect = $ReferenceRect
@onready var size: Vector2 = reference_rect.size
var cell_size: Vector2 = Vector2(16, 16)
var cells: Dictionary = {}
var free_cells : Array:
	get:
		if !free_cells:
			var cv: Array = cells.values()
			for coln in range(cv.size()):
				var collumn: Dictionary = cv[coln]
				for ycell in collumn:
					if collumn[ycell] == 0:
						free_cells.append(Vector2(coln, ycell))
					
		return free_cells
				

func _input(event: InputEvent) -> void:
	if event is InputEventKey && event.is_pressed() && event.keycode == KEY_H:
		graphics.visible = !graphics.visible

func _ready() -> void:
	for xx in range(size.x / cell_size.x):
		cells[xx] = {}
		for yy in range(size.y / cell_size.y):
			cells[xx][yy] = 0

func is_cell_free(coords: Vector2) -> bool:
	return free_cells.has(coords)

func get_rand_free_cell() -> Vector2:
	return free_cells.pick_random()

func occupy_cell(coords: Vector2) -> void:
	if free_cells.has(coords):
		free_cells.erase(coords)

func free_cell(global_coords: Vector2) -> void:
	var coords: Vector2 = (global_coords - Vector2.ONE * cell_size.x / 2) / cell_size - Vector2.ONE
	if !free_cells.has(coords):
		free_cells.append(coords)

func get_cell_center(coords: Vector2) -> Vector2:
	return global_position + reference_rect.get_rect().position + coords * cell_size.x + Vector2.ONE * cell_size.x / 2
