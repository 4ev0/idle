extends ButtonGraphics
class_name CapsuleQuestsGraphics

var tw: Tween
@onready var capsule_sprite: Sprite2D = %CapsuleQuest
@onready var capsule_sprite_container: Node2D = $CapsuleSpriteContainer
@onready var exclamation_mark: Sprite2D = $CapsuleSpriteContainer/ExclamationMark
@onready var falling_t: float = parent.falling_t

func _ready() -> void:
	super()
	parent.active_changed.connect(_on_active_changed)
	parent.drop_requested.connect(_on_drop_requested)
	
func _on_drop_requested() -> void:
	if exclamation_mark.visible:
		exclamation_mark.hide()
		
	if tw:
		tw.kill()
		
	tw = create_tween()
	capsule_sprite.scale = Vector2(1, 1.5)
	tw.tween_callback(func() -> void:
		capsule_sprite.scale = Vector2(1.5, 0.6)).set_delay(falling_t)
	tw.tween_property(capsule_sprite, "scale", Vector2.ONE, 0.15).set_ease(Tween.EASE_IN)
	
	
func _on_active_changed(active: bool, quest_completed: bool) -> void:
	if !active:
		return
		
	if tw:
		tw.kill()
		
	tw = create_tween()
	capsule_sprite.scale = Vector2(1, 1.5)
	tw.tween_callback(func() -> void:
		capsule_sprite.scale = Vector2(1.5, 0.6)).set_delay(falling_t)
	tw.tween_property(capsule_sprite, "scale", Vector2.ONE, 0.15).set_ease(Tween.EASE_IN)
	await tw.finished
	if quest_completed:
		exclamation_mark.show()

func _on_button_hitted(v: int) -> void:
	var hc: HitCircle = HitCircle.new()
	var mouse_pos: Vector2 = get_global_mouse_position()
	hc.global_position = Vector2(sign(global_position.direction_to(mouse_pos).x) * 3, -7)
	add_child(hc)

	if tw:
		tw.kill()
		
	tw = create_tween()
	capsule_sprite_container.rotation = deg_to_rad(sign(parent.global_position.direction_to(mouse_pos).x) * 15)
	tw.set_parallel()
	tw.tween_property(capsule_sprite_container, "rotation", 0, 0.15).set_ease(Tween.EASE_OUT)
	tw.tween_property(capsule_sprite, "position:y", -2.5, 0.15).set_ease(Tween.EASE_OUT)
	
	tw.tween_property(capsule_sprite, "position:y", 0, 0.2).set_ease(Tween.EASE_IN).set_delay(0.15)

func _on_button_accepted() -> void:
	if exclamation_mark.visible:
		exclamation_mark.hide()
