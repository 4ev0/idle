extends Area2D
class_name RoomChanger

@export var parent_room: Room
@export var target_room: Room
static var manager: RoomChangeManager
@onready var collision: CollisionShape2D = $CollisionShape2D
@export var working_states: Array[G.GameStates] = [G.GameStates.GAME]

func _ready() -> void:
	monitorable = false
	set_collision_layer_value(1, 0)
	area_entered.connect(_on_area_entered)
	set_disabled(true)
	await G.main_ready
	manager.register(self, parent_room)
	
func _on_area_entered(area: Area2D) -> void:
	if !working_states.has(G.game_state):
		return
		 
	manager.change_requested.emit(target_room, parent_room)

func set_disabled(enabled: bool) -> void:
	set_deferred("monitoring", !enabled)
	#collision.set_deferred("disabled", enabled)
