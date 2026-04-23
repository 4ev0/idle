extends Node2D
class_name TelephoneController

var pickup: PickupComponent
var parent: Telephone

func _ready() -> void:
	pickup.sliced.connect(_on_sliced)
	set_physics_process(false)
	
func _physics_process(delta: float) -> void:
	parent.handset_y = max((get_local_mouse_position().y - parent.handset_offset_y) / 2, parent.max_handset_y) 
	if parent.handset_y >= 0:
		parent.handset_y = 0
		set_physics_process(false)
		pickup.picked = false
		parent.picked = false
	
func _on_sliced() -> void:
	set_physics_process(true)
	parent.picked = true
