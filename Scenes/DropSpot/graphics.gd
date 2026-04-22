extends Node2D
class_name DropSpotGraphics

var parent: DropSpot
@onready var label_quota: Label = %LabelQuota
var animation_playing: bool = false
var tw: Tween

func _ready() -> void:
	parent.weight_updated.connect(_on_weight_updated)
	
func _on_weight_updated(v: int) -> void:
	if animation_playing:
		return
		
	label_quota.text = "%d" %v
	
func play_quota_change_animation(new_target: int, reward: int = 10) -> void:
	animation_playing = true
	if tw:
		tw.kill()
	
	var label_pos: Vector2 = label_quota.position
	label_quota.scale = Vector2(1.5, 1.6)
	label_quota.modulate = Color.WEB_GREEN
	tw = create_tween()
	tw.tween_property(label_quota, "scale", Vector2.ONE, 0.27).set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(label_quota, "position:y", label_pos.y - 4, 0.15).set_ease(Tween.EASE_IN_OUT).set_delay(0.75)
	tw.tween_callback(func() -> void:
		label_quota.position.y = label_pos.y + 4
		label_quota.text = "+%dO" %reward )
	tw.tween_property(label_quota, "position:y", label_pos.y, 0.25).set_ease(Tween.EASE_OUT)
	tw.tween_property(label_quota, "position:y", label_pos.y - 4, 0.15).set_ease(Tween.EASE_IN_OUT).set_delay(1)
	tw.tween_callback(func() -> void:
		label_quota.position.y = label_pos.y + 4
		label_quota.text = "%d" %reward
		label_quota.text = "%d" %new_target
		label_quota.modulate = Color.WHITE )
	tw.tween_property(label_quota, "position:y", label_pos.y, 0.25).set_ease(Tween.EASE_OUT)
	await tw.finished
	animation_playing = false
	parent.change_animation_finished.emit()
