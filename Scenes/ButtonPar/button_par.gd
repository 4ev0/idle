extends Control
class_name ButtonPar

var graphics: ButtonGraphics
var controller: ButtonController

@export var hit_buffer: int = 3

signal button_hitted(h: int)
signal button_accepted
signal accept_animation_finished

func is_hitted() -> bool:
	return true

func set_hitted(v: int) -> void:
	if !controller:
		return
	
	controller.hitted = v
	button_hitted.emit(v)
