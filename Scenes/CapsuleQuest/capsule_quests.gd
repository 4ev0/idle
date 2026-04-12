extends ButtonPar
class_name CapsuleQuests

@export var above_marker: Marker2D
@export var in_marker: Marker2D
@export var falling_t: float = 0.13
var active: bool = false:
	set(v):
		if active == v:
			return
			
		active = v
		active_changed.emit(active)

signal active_changed(enabled: bool)
