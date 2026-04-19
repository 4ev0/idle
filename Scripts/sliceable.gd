extends Area2D
class_name Sliceable

@export var min_velocity: float = 4
@onready var cursor: Cursor = G.get_n("cursor")
@export var working_states: Array[G.GameStates] = [G.GameStates.GAME]
var collision_shape: CollisionShape2D:
	get:
		if !collision_shape:
			collision_shape = get_node("CollisionShape2D")
		return collision_shape

@export var disabled: bool = false
var entered: bool = false

signal sliced

func _ready() -> void:
	monitorable = false
	
func set_collision_radius(r: float) -> void:
	if collision_shape:
		collision_shape.shape.radius = r

func slice() -> void:
	if disabled:
		return
		
	var t: Transition = G.get_n("transition")
	if t:
		if t.playing && t.animation != "transition_out":
			return
			
	if !working_states.has(G.game_state):
		return
		
	if slice_condition():
		sliced.emit()
	
func slice_condition() -> bool:
	return true

func set_disabled(enabled: bool) -> void:
	disabled = enabled

func get_dir_to_cursor() -> Vector2:
	return global_position.direction_to(cursor.global_position)
