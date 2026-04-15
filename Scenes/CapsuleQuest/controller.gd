extends ButtonController
class_name CapsuleQuestsController

@onready var above_pos: Vector2 = parent.above_marker.global_position
@onready var in_pos: Vector2 = parent.in_marker.global_position
var tw: Tween
@onready var falling_t: float = parent.falling_t

func _ready() -> void:
	super()
	if !parent.active:
		parent.global_position = above_pos
	
	parent.active_changed.connect(_on_active_changed)
	parent.drop_requested.connect(_on_drop_requested)

func _on_drop_requested() -> void:
	if tw:
		tw.kill()
		
	tw = create_tween()
	parent.global_position.y += 8
	tw.tween_property(parent, "global_position", in_pos + Vector2(0, 20), falling_t).set_ease(Tween.EASE_OUT)
	await tw.finished
	reset_capsule()
	parent.capsule_dropped.emit()
	
func _on_active_changed(active: bool, quest_completed: bool) -> void:
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

func reset_capsule() -> void:
	hitted = 0
	parent.global_position = above_pos
	parent.active = false

func _on_button_accepted() -> void:
	reset_capsule()
	var ql: QuestList = G.get_n("quest_list")
	print(ql)
	if ql:
		if !ql.active:
			ql.show()
