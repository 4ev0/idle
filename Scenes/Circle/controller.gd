extends Node2D
class_name CircleController

var parent: Circle
var mouse_in: bool = false
var hit_ready: bool = true
@onready var qm: QuestManager = G.get_n("quest_manager"):
	get:
		if !qm:
			qm = G.get_n("quest_manager")
		
		return qm

var sliceable: Sliceable

var coin_scene: PackedScene = load("uid://c6g5a4ot6t8tx")

func _ready() -> void:
	if sliceable:
		sliceable.sliced.connect(_on_sliced)
		sliceable.set_collision_radius(parent.radius)
		parent.visibility_changed.connect(_on_visibility_changed)
	
	parent.respawn_requested.connect(spawn)
	spawn()
	
func _on_visibility_changed() -> void:
	sliceable.disabled = !parent.visible
	
func _on_sliced() -> void:
	parent.value -= G.strength - parent.data.durability
	parent.sliced.emit(get_global_mouse_position())

func spawn() -> void:
	parent.show()
	var grid: Grid = G.get_n("grid")
	var target_cell_pos : Vector2 = grid.get_rand_free_cell()
	parent.global_position = grid.get_cell_center(target_cell_pos)
	grid.occupy_cell(target_cell_pos)
	parent.value = parent.data.hp
	parent.spawned.emit()

func die() -> void:
	if qm:
		qm.count_cutted(parent.type)
	
	var c: ParticleCoin = coin_scene.instantiate()
	c.global_position = global_position
	G.get_n("main").add_child(c) #todo: add coin container
	G.get_n("grid").free_cell(global_position)
	parent.died.emit()
	match G.get_n("circle_manager").store_or_delete_or_respawn(parent):
		"store":
			parent.hide()
		"respawn":
			spawn()
		"delete":
			parent.queue_free()
	
