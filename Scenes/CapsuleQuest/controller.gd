extends ButtonController
class_name CapsuleQuestsController

@onready var above_pos: Vector2 = parent.above_marker.global_position
@onready var in_pos: Vector2 = parent.in_marker.global_position
var tw: Tween
@onready var falling_t: float = parent.falling_t

func _ready() -> void:
	super()
	parent.global_position = above_pos
	parent.active_changed.connect(_on_active_changed)
	
func _on_active_changed(active: bool) -> void:
	if !active:
		return
		
	if tw:
		tw.kill()
		
	tw = create_tween()
	tw.tween_property(parent, "global_position", in_pos, falling_t).set_ease(Tween.EASE_OUT)

func is_hitted() -> bool:
	if parent.active:
		return true
		
	return false

func _on_button_accepted() -> void:
	hitted = 0
	parent.global_position = above_pos
	parent.active = false
