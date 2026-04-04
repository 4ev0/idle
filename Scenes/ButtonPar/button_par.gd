extends Control
class_name ButtonPar

var graphics: ButtonGraphics
var controller: ButtonController

@export var hit_buffer: int = 3

signal button_hitted(h: int)
signal button_accepted

func is_hitted() -> bool:
	return true
