extends ButtonPar
class_name CapsulePar

@export var above_marker: Marker2D
@export var in_marker: Marker2D
@export var falling_t: float = 0.13
@export var active: bool = false

signal drop_requested
signal capsule_dropped
signal active_changed(enabled: bool, args: Variant)

func set_active(v: bool) -> void:
	if active == v:
		return
		
	active = v
