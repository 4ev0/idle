extends Node2D
class_name TelephoneGraphics

var parent: Telephone
@onready var sprite_base: Sprite2D = %TelephoneBase
@onready var sprite_handset: Sprite2D = %TelephoneHandset
@onready var sprite_wire: Sprite2D = %TelephoneWire

func _ready() -> void:
	parent.handset_picked.connect(_on_picked)
	parent.handset_offset_y = sprite_handset.position.y
	
func _physics_process(delta: float) -> void:
	var offset: float = parent.handset_offset_y
	var handset_y: float = parent.handset_y
	sprite_handset.position.y = offset + handset_y / 2.5
	sprite_handset.rotation = handset_y * parent.target_rotation / parent.max_handset_y
	#sprite_handset.rotation = 
	
func _on_picked() -> void:
	sprite_handset.hide()
	sprite_wire.hide()
