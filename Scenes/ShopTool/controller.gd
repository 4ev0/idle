extends Node2D
class_name ShopToolContoller

var pickup: PickupComponent
var parent: ShopTool
var picked: bool = false

func _ready() -> void:
	pickup.sliced.connect(_on_sliced)
	
func _on_sliced() -> void:
	if pickup.picked:
		if G.tool_picked:
			pickup.picked = false
			return
			
		G.tool_picked = parent.type
		parent.picked.emit()
	else:
		G.tool_picked = 0
		parent.placed.emit()
