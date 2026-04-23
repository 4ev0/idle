extends Node2D
class_name TelephoneGraphics

var parent: Telephone
@onready var sprite_base: Sprite2D = %TelephoneBase
@onready var sprite_handset: Sprite2D = %TelephoneHandset
@onready var sprite_wire: Sprite2D = %TelephoneWire
@onready var offset: float = sprite_handset.position.y

func _ready() -> void:
	set_physics_process(false)
	parent.handset_picked.connect(_on_picked)
	parent.telephone_used.connect(_on_used)
	parent.handset_offset_y = offset
	
func _physics_process(delta: float) -> void:
	var handset_y: float = parent.handset_y
	sprite_handset.position.y = offset + handset_y / 2.5
	sprite_handset.rotation = handset_y * parent.target_rotation / parent.max_handset_y
	
func _on_used() -> void:
	set_physics_process(false)
	sprite_handset.position.y = offset
	sprite_handset.rotation = 0
	
func _on_picked() -> void:
	set_physics_process(true)
