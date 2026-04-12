extends Node2D
class_name ShopToolContoller

var pickup: PickupComponent
var parent: ShopTool
var picked: bool = false

func _ready() -> void:
	pickup.sliced.connect(_on_sliced)
	
func _on_sliced() -> void:
	if pickup.picked:
		parent.picked.emit()
	else:
		parent.placed.emit()
