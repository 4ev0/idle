extends PickupComponent
class_name PickupBowl

var parent: BowlController

func slice_condition() -> bool:
	if parent.spoon_in:
		return false
		
	return check_picked()
