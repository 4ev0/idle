extends ButtonGraphics
class_name CapsuleGraphics

@onready var capsule_sprite: Sprite2D = %CapsuleSprite
@onready var capsule_sprite_container: Node2D = $CapsuleSpriteContainer
@onready var falling_t: float = parent.falling_t
@export var hit_r_deg: float = 15
var tw: Tween

func _ready() -> void:
	super()
	parent.drop_requested.connect(_on_drop_requested)

func _on_drop_requested() -> void:
	drop_anim()

func drop_anim() -> void:
	if tw:
		tw.kill()
		
	tw = create_tween()
	capsule_sprite.scale = Vector2(1, 1.5)
	tw.tween_callback(func() -> void:
		capsule_sprite.scale = Vector2(1.5, 0.6)).set_delay(falling_t)
	tw.tween_property(capsule_sprite, "scale", Vector2.ONE, 0.15).set_ease(Tween.EASE_IN)

func place_anim() -> void:
	if tw:
		tw.kill()
		
	tw = create_tween()
	capsule_sprite.scale = Vector2(1, 1.5)
	tw.tween_callback(func() -> void:
		capsule_sprite.scale = Vector2(1.5, 0.6)).set_delay(falling_t)
	tw.tween_property(capsule_sprite, "scale", Vector2.ONE, 0.15).set_ease(Tween.EASE_IN)
	
func _on_button_hitted(v: int) -> void:
	var hc: HitCircle = HitCircle.new()
	var mouse_pos: Vector2 = get_global_mouse_position()
	hc.global_position = Vector2(sign(global_position.direction_to(mouse_pos).x) * 3, -7)
	add_child(hc)
	if tw:
		tw.kill()
		
	tw = create_tween()
	capsule_sprite_container.rotation = deg_to_rad(sign(parent.global_position.direction_to(mouse_pos).x) * hit_r_deg)
	tw.set_parallel()
	tw.tween_property(capsule_sprite_container, "rotation", 0, 0.15).set_ease(Tween.EASE_OUT)
	tw.tween_property(capsule_sprite, "position:y", -2.5, 0.15).set_ease(Tween.EASE_OUT)
	
	tw.tween_property(capsule_sprite, "position:y", 0, 0.2).set_ease(Tween.EASE_IN).set_delay(0.15)
