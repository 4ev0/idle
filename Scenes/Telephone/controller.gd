extends Node2D
class_name TelephoneController

var pickup: PickupComponent
var parent: Telephone

func _ready() -> void:
	pickup.sliced.connect(_on_sliced)
	
func _physics_process(delta: float) -> void:
	if !parent.picked:
		return
		
	parent.handset_y = max((get_local_mouse_position().y - parent.handset_offset_y) / 2, parent.max_handset_y) 
	if parent.handset_y >= 0:
		parent.handset_y = 0
		parent.picked = false
	
func _on_sliced() -> void:
	parent.picked = true
