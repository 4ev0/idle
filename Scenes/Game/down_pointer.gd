extends Sprite2D
class_name DownPointer

#todo: move to room changer

@onready var salad_manager: SaladManager = G.get_n("salad_manager")

func _ready() -> void:
	salad_manager.enough_weight.connect(_on_enough_weight)
	salad_manager.target_changed.connect(_on_target_changed)
	
func _on_enough_weight() -> void:
	show()
	
func _on_target_changed(v: int) -> void:
	hide()
