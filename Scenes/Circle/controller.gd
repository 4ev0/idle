extends Node2D
class_name CircleController

var parent: Circle
var mouse_in: bool = false
var hit_ready: bool = true
var stage_buffer: float = 0
static var quest_manager: QuestManager
static var manager: CircleManager
static var coin_container: CoinContainer
static var bowl: Bowl
static var grid: Grid

var sliceable: Sliceable

var coin_scene: PackedScene = load("uid://c6g5a4ot6t8tx")

func _ready() -> void:
	if sliceable:
		sliceable.sliced.connect(_on_sliced)
		sliceable.set_collision_radius(parent.radius)
		parent.visibility_changed.connect(_on_visibility_changed)
	
	parent.respawn_requested.connect(spawn)
	parent.frame_updated.connect(_on_frame_updated)
	spawn()
	
func _on_frame_updated(f: int) -> void:
	bowl.weight += parent.data.stage_weight
	
func _on_visibility_changed() -> void:
	sliceable.disabled = !parent.visible
	
func _on_sliced() -> void:
	var str: int = G.strength
	var new_v: float = parent.value - str #- parent.data.durability
	var stage_step: float = parent.data.hp / parent.frame_count
	var v: float = str / stage_step
	if str < stage_step:
		stage_buffer += v
	
	if stage_buffer >= 1:
		for i in range(floor(stage_buffer)):
			parent.frame += 1
			stage_buffer -= 1
	else:
		for i in range(floor(v)):
			parent.frame += 1
				
	parent.value = new_v
	parent.sliced.emit(get_global_mouse_position())

func spawn() -> void:
	parent.frame = 0
	parent.show()
	var target_cell_pos : Vector2
	if !parent.target_pos || !grid.is_cell_free(grid.get_cell_coords(parent.target_pos)):
		target_cell_pos = grid.get_rand_free_cell()
	else:
		target_cell_pos = grid.get_cell_coords(parent.target_pos)
		parent.target_pos = Vector2.ZERO
		
	parent.global_position = grid.get_cell_center(target_cell_pos)
	grid.occupy_cell(target_cell_pos)
	parent.value = parent.data.hp
	parent.spawned.emit()

func die() -> void:
	var type: CircleManager.CircleTypes = parent.type
	if manager:
		manager.circle_died.emit(type)
	
	if quest_manager:
		quest_manager.count_cutted(type)
	
	var c: ParticleCoin = coin_scene.instantiate()
	c.value = parent.data.cost
	c.global_position = global_position
	if coin_container:
		coin_container.add_child(c)
	else:
		G.get_n("main").add_child(c)
		
	grid.free_cell(global_position)
	parent.died.emit()
	match G.get_n("circle_manager").store_or_delete_or_respawn(parent):
		"store":
			parent.hide()
		"respawn":
			call_deferred("spawn")
		"delete":
			parent.queue_free()
	
