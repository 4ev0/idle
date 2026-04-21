extends CapsuleController
class_name CapsuleTokenController
	
@onready var salad_manager: SaladManager = G.get_n("salad_manager")

func _ready() -> void:
	super()
	salad_manager.salad_submitted.connect(func() -> void: parent.set_active(true))
	
func _on_button_accepted() -> void:
	reset_capsule()
	G.tokens += 10
