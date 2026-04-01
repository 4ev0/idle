extends Node2D
class_name ButtonController

var sliceable: Sliceable
var parent: ButtonPar

func _ready() -> void:
	sliceable.sliced.connect(_on_sliced)
	
func _on_sliced() -> void:
	if !parent:
		return
		
	parent.hitted += 1
