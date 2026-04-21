extends Node2D
class_name CapsuleContainer

var parent: Pipe
@onready var capsule_quests: CapsuleQuests = %CapsuleQuests

func _ready() -> void:
	parent.lever_pulled.connect(_on_lever_pulled)
	
func _on_lever_pulled() -> void:
	if !capsule_quests.active && !capsule_quests.quest_completed:
		await get_tree().create_timer(1.45).timeout
		if !capsule_quests.quest_completed:
			capsule_quests.set_active(true)
		
