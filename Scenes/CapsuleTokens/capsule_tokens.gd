extends CapsulePar
class_name CapsuleTokens

var value: int = 0

func set_active(v: bool) -> void:
	if v == active:
		return
		
	active = v
	active_changed.emit(active)
