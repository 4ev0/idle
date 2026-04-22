extends CapsuleController
class_name CapsuleTokenController

func _ready() -> void:
	super()
	G.salad_submitted.connect(_on_salad_submitted)

func _on_salad_submitted() -> void:
	parent.set_active(true)
	parent.value += 10

func _on_button_accepted() -> void:
	reset_capsule()
	G.tokens += parent.value
	parent.value = 0
