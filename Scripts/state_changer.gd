extends Node2D
class_name StateChanger

@export var target_state: G.GameStates
@onready var shop: StateChanger = %Shop
@onready var factory: StateChanger = %Factory
@onready var telephone_upgrade: StateChanger = %TelephoneUpgrade


func _ready() -> void:
	visibility_changed.connect(_on_visibility_changed)
	_on_visibility_changed()
	
func _on_visibility_changed() -> void:
	if visible:
		G.game_state = target_state
