extends Sliceable
class_name PickupComponent

var picked: bool = false
@export var dir: int = 1
@export var auto_picked: bool = true

func slice_condition() -> bool:
	if picked:
		if sign(get_dir_to_cursor().y) == sign(dir):
			if auto_picked:
				picked = false
	
			return true
	else:
		if sign(get_dir_to_cursor().y) != sign(dir):
			if auto_picked:
				picked = true
	
			return true
			
	return false
