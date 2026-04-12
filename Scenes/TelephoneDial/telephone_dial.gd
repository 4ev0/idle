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
