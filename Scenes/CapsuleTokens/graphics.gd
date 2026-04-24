extends CapsuleGraphics
class_name CapsuleTokensGraphics

func _ready() -> void:
	super()
	parent.active_changed.connect(_on_active_changed)
	parent.capsule_center_offset = capsule_sprite.offset
	
func _on_active_changed(active: bool) -> void:
	if !active:
		return
		
	place_anim()
