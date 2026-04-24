extends CapsuleController
class_name CapsuleTokenController

static var container: TokerContainer

func _ready() -> void:
	super()
	G.salad_submitted.connect(_on_salad_submitted)

func _on_salad_submitted() -> void:
	parent.set_active(true)
	parent.value += 10

func _on_button_accepted() -> void:
	container.add_tokens(parent.value, parent.global_position + parent.capsule_center_offset)
	reset_capsule()
	parent.value = 0
	
