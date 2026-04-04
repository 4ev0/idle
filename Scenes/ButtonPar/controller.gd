extends Node2D
class_name ButtonController

var sliceable: Sliceable
var parent: ButtonPar

var hitted: int = 0

func _ready() -> void:
	await G.main_ready
	if sliceable:
		sliceable.sliced.connect(_on_sliced)
	
	if parent:
		parent.button_accepted.connect(_on_button_accepted)
		parent.button_hitted.connect(_on_button_hitted)
	
func is_hitted() -> bool:
	return true

func _on_sliced() -> void:
	if !parent || !is_hitted():
		return
	
	print(self)
		
	hitted += 1
	if hitted >= parent.hit_buffer:
		hitted = 0
		parent.button_accepted.emit()
	else:
		parent.button_hitted.emit(hitted)

func _on_button_accepted() -> void:
	pass
	
func _on_button_hitted(v: int) -> void:
	pass
