extends Node2D
class_name Grid

var graphics: GridGraphics
@onready var reference_rect: ReferenceRect = $ReferenceRect
@onready var size: Vector2 = reference_rect.size
var cell_size: Vector2i = Vector2i(16, 16)
var cells: Dictionary = {}
var free_cells : Array[Vector2i]:
	get:
		if !free_cells:
			var cv: Array = cells.values()
			for coln in range(cv.size()):
				var collumn: Dictionary = cv[coln]
				for ycell in collumn:
					if collumn[ycell] == 0:
						free_cells.append(Vector2i(coln, ycell))
					
		return free_cells
				
var occupied_cells: Array[Vector2i] = []

func _enter_tree() -> void:
	CircleController.grid = self
	ParticleCoin.grid = self

func _input(event: InputEvent) -> void:
	if event is InputEventKey && event.is_pressed() && event.keycode == KEY_H:
		graphics.visible = !graphics.visible

func _ready() -> void:
	for xx in range(int(size.x / cell_size.x)):
		cells[xx] = {}
		for yy in range(int(size.y / cell_size.y)):
			cells[xx][yy] = 0

func is_cell_free(coords: Vector2i) -> bool:
	return free_cells.has(coords)

func get_rand_free_cell() -> Vector2i:
	return free_cells.pick_random()

func occupy_cell(coords: Vector2i) -> void:
	if free_cells.has(coords):
		free_cells.erase(coords)
		occupied_cells.append(coords)

func is_in_bounds(coords: Vector2i) -> bool:
	return sign(coords) < Vector2i.ZERO && coords.aspect() < 0

func get_closest_circle(from_coords: Vector2i = Vector2i.ZERO) -> Vector2i:
	var closest: Vector2i = Vector2i(-1,-1)
	if occupied_cells.size() >= 2:
		for i in occupied_cells:
			if from_coords == i:
				continue
				
			if !closest:
				closest = i
				continue
			
			if from_coords.distance_to(i) < from_coords.distance_to(closest):
				closest = i
	
	return closest

func free_cell(global_coords: Vector2) -> void:
	var coords: Vector2i = get_cell_coords(global_coords, int(global_coords.x) % int(cell_size.x/2) == 0)
	if !free_cells.has(coords):
		free_cells.append(coords)
		occupied_cells.erase(coords)

func get_cell_center(coords: Vector2) -> Vector2:
	return global_position + reference_rect.get_rect().position + coords * cell_size.x + Vector2.ONE * cell_size.x / 2

func get_cell_coords(global_coords: Vector2, centered: bool = false) -> Vector2i:
	var uncentered_coords: Vector2i = global_coords if !centered else (global_coords - Vector2.ONE * cell_size.x / 2)
	return uncentered_coords / cell_size - Vector2i.ONE
