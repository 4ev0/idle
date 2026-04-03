extends Control
class_name ButtonPar

var graphics: ButtonGraphics
var controller: ButtonController

var hit_buffer: int = 3
var hitted: int = 0:
	set(v):
		if !is_hitted():
			return
			
		if v == hit_buffer:
			hitted = 0
			button_accepted.emit()
		else:
			hitted = v
			button_hitted.emit(hitted)

signal button_hitted(h: int)
signal button_accepted()

func is_hitted() -> bool:
	return true
