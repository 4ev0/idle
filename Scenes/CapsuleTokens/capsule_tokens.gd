extends CapsulePar
class_name CapsuleTokens

func set_active(v: bool) -> void:
	super(v)
	active_changed.emit(active)
