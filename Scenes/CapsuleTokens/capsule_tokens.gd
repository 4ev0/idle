extends CapsulePar
class_name CapsuleTokens

@export var value: int = 0
var capsule_center_offset: Vector2 = Vector2.ZERO

func set_active(v: bool) -> void:
	if v == active:
		return
		
	active = v
	active_changed.emit(active)
