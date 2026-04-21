extends CapsuleGraphics
class_name CapsuleQuestsGraphics

@onready var exclamation_mark: Sprite2D = $CapsuleSpriteContainer/ExclamationMark

func _ready() -> void:
	super()
	parent.active_changed.connect(_on_active_changed)
	
	
func _on_active_changed(active: bool, quest_completed: bool) -> void:
	if !active:
		return
		
	place_anim()
	await tw.finished
	if quest_completed:
		exclamation_mark.show()

func _on_drop_requested() -> void:
	if exclamation_mark.visible:
		exclamation_mark.hide()
		
	drop_anim()

func _on_button_accepted() -> void:
	if exclamation_mark.visible:
		exclamation_mark.hide()
