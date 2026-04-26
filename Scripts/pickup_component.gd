extends Sliceable
class_name PickupComponent

var picked: bool = false
@export var dir: int = 1
@export var horizontal_check: bool = false
@export var auto_picked: bool = true

func slice_condition() -> bool:
	return check_picked()

func check_picked() -> bool:
	var cursor_dir: int = sign(get_dir_to_cursor().y) if !horizontal_check else sign(-get_dir_to_cursor().x)
	if picked:
		if cursor_dir == sign(dir):
			if auto_picked:
				picked = false
	
			return true
	else:
		if cursor_dir != sign(dir):
			if auto_picked:
				picked = true
	
			return true
			
	return false
	
