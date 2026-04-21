extends CapsulePar
class_name CapsuleQuests

var quest_completed: bool = false
	
func set_active(v: bool) -> void:
	super(v)
	active_changed.emit(active, quest_completed)
	if quest_completed:
		quest_completed = false
