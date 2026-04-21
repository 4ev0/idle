extends ButtonController
class_name CapsuleController

@onready var above_pos: Vector2 = parent.above_marker.global_position
@onready var in_pos: Vector2 = parent.in_marker.global_position
@onready var falling_t: float = parent.falling_t
@onready var camera: Camera = G.get_n("camera")
var tw: Tween

func _ready() -> void:
	super()
	if !parent.active:
		parent.global_position = above_pos
		
	parent.drop_requested.connect(_on_drop_requested)
	parent.active_changed.connect(_on_active_changed)

func _on_drop_requested() -> void:
	if tw:
		tw.kill()
		
	tw = create_tween()
	parent.global_position.y += 8
	tw.tween_property(parent, "global_position", in_pos + Vector2(0, 20), falling_t).set_ease(Tween.EASE_OUT)
	await tw.finished
	reset_capsule()
	parent.capsule_dropped.emit()

func reset_capsule() -> void:
	hitted = 0
	parent.global_position = above_pos
	parent.set_active(false)
	
func _on_active_changed(active: bool, args: Variant = null) -> void:
	if !active:
		return
		
	place()
	
func is_hitted() -> bool:
	if parent.active:
		return true
		
	return false

func place() -> void:
	if tw:
		tw.kill()
		
	tw = create_tween()
	tw.tween_property(parent, "global_position", in_pos, falling_t).set_ease(Tween.EASE_OUT)
