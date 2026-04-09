extends ButtonForPurchaseGraphics
class_name ButtonCircleBuyGraphics

@onready var circle_sprite: Sprite2D = %CircleSprite
var tw: Tween
@onready var label_container: Control = $LabelContainer
@onready var label_pos: Vector2 = label_container.position

func _ready() -> void:
	super()
	circle_sprite.texture = G.circle_atlas_textures[parent.circle_type]
	purchase.purchased.connect(_on_purchased)
	

func _on_purchased() -> void:
	if tw:
		tw.kill()
		
	tw = create_tween()
	circle_sprite.position.y = 0
	circle_sprite.scale = Vector2.ONE
	circle_sprite.modulate.a = 1
	label_container.position.y = label_pos.y -5
	label_container.scale = Vector2(0.65, 1.64)
	tw.set_parallel()
	tw.tween_property(circle_sprite, "scale", Vector2(0.75,1.3), 0.1).set_ease(Tween.EASE_IN)
	tw.tween_property(label_container, "position:y", label_pos.y, 0.13).set_ease(Tween.EASE_OUT)
	tw.tween_property(label_container, "scale", Vector2.ONE, 0.13).set_ease(Tween.EASE_OUT)
	tw.tween_property(circle_sprite, "position:y", -8, 0.15).set_ease(Tween.EASE_IN)
	tw.tween_property(circle_sprite, "modulate:a", 0, 0.15).set_ease(Tween.EASE_IN)
	tw.set_parallel(false)
	tw.tween_callback(func() -> void:
		circle_sprite.position.y = 0
		circle_sprite.scale = Vector2.ZERO
		circle_sprite.modulate.a = 1 )
	tw.tween_property(circle_sprite, "scale", Vector2.ONE, 0.18).set_ease(Tween.EASE_OUT)
	
