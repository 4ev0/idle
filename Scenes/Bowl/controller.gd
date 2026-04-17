extends Node2D
class_name BowlController

var parent: Bowl
var pickup: PickupComponent
var spoon_in: bool = false

func _ready() -> void:
	pickup.sliced.connect(_on_sliced)
	
func _on_sliced() -> void:
	spoon_in = !spoon_in
	if spoon_in:
		parent.spoon_entered.emit()
	else:
		parent.spoon_exited.emit()
		
