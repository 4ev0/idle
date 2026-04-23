extends Node2D
class_name TelephoneDial

var focused: bool = false
var graphics: TelephoneDialGraphics
var disabled: bool = true:
	set(v):
		disabled = v
		disable.emit(disabled)

signal button_submitted
signal disable(enabled: bool)

func _ready() -> void:
	var par: Node2D = get_parent()
	par.visibility_changed.connect(Callable(func() -> void: disabled = !par.visible))
