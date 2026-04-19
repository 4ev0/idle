extends Node2D
class_name DropSpotController

var parent: DropSpot
@onready var bowl: Bowl = parent.bowl
@onready var area: Area2D = $Area2D
@onready var collision: CollisionShape2D = $Area2D/CollisionShape2D

func _ready() -> void:
	bowl.bowl_picked.connect(_on_bowl_picked)
	area_set_disabled(!bowl.is_picked())
	area.area_entered.connect(func(a: Area2D) -> void: if G.is_cursor_busy(): bowl._in_drop_spot = true)
	area.area_exited.connect(func(a: Area2D) -> void: bowl._in_drop_spot = false)
	
func _on_bowl_picked() -> void:
	area_set_disabled(false)
	
func area_set_disabled(enabled: bool) -> void:
	collision.call_deferred("set_disabled", enabled)
	
