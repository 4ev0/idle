extends PickupComponent
class_name PickupBowl

var parent: BowlController
@onready var salad_manager: SaladManager = parent.salad_manager

func _ready() -> void:
	super()
	await G.main_ready
	salad_manager = parent.salad_manager

func slice_condition() -> bool:
	if parent.spoon_in:
		return false
		
	return check_picked()
