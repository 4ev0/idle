extends Control
class_name QuestList

@onready var button: Button = $Button
var active: bool = false
@onready var shrinking_container: ShrinkingContainer = $ShrinkingContainer

func _ready() -> void:
	button.pressed.connect(_on_pressed)
	visibility_changed.connect(_on_visibility_changed)
	_on_visibility_changed()
	
func _on_visibility_changed() -> void:
	active = visible
	shrinking_container.set_physics_process(active)
	
func _on_pressed() -> void:
	hide()
