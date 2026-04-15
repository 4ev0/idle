extends ButtonPar
class_name CapsuleQuests

@export var above_marker: Marker2D
@export var in_marker: Marker2D
@export var falling_t: float = 0.13
@onready var camera: Camera = G.get_n("camera")
@export var active: bool = false:
	set(v):
		if active == v:
			return
			
		active = v
		active_changed.emit(active, quest_completed)
		if quest_completed:
			quest_completed = false
			
var quest_completed: bool = false

signal active_changed(enabled: bool, quest_completed: bool)
signal drop_requested
signal capsule_dropped

func _ready() -> void:
	G.get_n("quest_manager").quest_completed.connect(_on_quest_completed)
	
func _on_quest_completed() -> void:
	if active:
		drop_requested.emit()
		await capsule_dropped
		
	if camera:
		camera.shake(1, 0.1)
	quest_completed = true
	await get_tree().create_timer(2.1).timeout
	active = true
	
