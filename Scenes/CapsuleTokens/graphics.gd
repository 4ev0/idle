extends CapsuleGraphics
class_name CapsuleTokensGraphics

func _ready() -> void:
	super()
	parent.active_changed.connect(_on_active_changed)
	
func _on_active_changed(active: bool) -> void:
	if !active:
		return
		
	place_anim()
