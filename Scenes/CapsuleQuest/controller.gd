extends CapsuleController
class_name CapsuleQuestsController

func _ready() -> void:
	super()
	G.get_n("quest_manager").quest_completed.connect(_on_quest_completed)

func _on_quest_completed() -> void:
	if parent.active:
		parent.drop_requested.emit()
		await parent.capsule_dropped
		
	if camera:
		camera.shake(10, 0.1)
		
	parent.quest_completed = true
	await get_tree().create_timer(2.1).timeout
	parent.set_active(true)
	
func _on_button_accepted() -> void:
	reset_capsule()
	var ql: QuestList = G.get_n("quest_list")
	if ql:
		if !ql.active:
			ql.show()
