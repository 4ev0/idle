extends Node
class_name Pulse

@onready var parent: Node2D = get_parent()
@export var min_v: float = 0
@export var max_v: float = 1
@export var duration: float = 0.35
var tw: Tween

func _ready() -> void:
	parent.visibility_changed.connect(_on_visibility_changed)
	_on_visibility_changed()
	
func _on_visibility_changed() -> void:
	if !parent.visible:
		if tw:
			tw.kill()
	else:
		pulse()
	
func pulse() -> void:
	if !parent.visible:
		return
	
	if tw:
		tw.kill()
		
	tw = create_tween()
	parent.modulate.a = max_v
	tw.tween_property(parent, "modulate:a", min_v, duration).set_ease(Tween.EASE_IN_OUT)
	await tw.finished
	pulse()
	
