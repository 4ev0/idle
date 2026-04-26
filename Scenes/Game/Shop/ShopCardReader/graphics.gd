extends Node2D
class_name ShopCardReaderGraphics

var parent: ShopCardReader
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $ShopCardReaderSprite
@onready var credit_card_sprite: Sprite2D = $CreditCard
var tw: Tween

func _ready() -> void:
	var pm: ShopProductManager = parent.product_manager
	pm.res_cash_setted.connect(_on_res_cash_setted)
	pm.res_cash_unsetted.connect(_on_res_cash_unsetted)
	
func _on_res_cash_setted() -> void:
	animation_player.play("flash")

func _on_res_cash_unsetted() -> void:
	animation_player.stop
	animation_player.play("RESET")
	if tw:
		tw.kill()
		
	tw = create_tween()
	credit_card_sprite.modulate.a = 0
	credit_card_sprite.position.y = -18
	sprite.scale = Vector2(0.9, 1.2)
	sprite.position.y = -2
	tw.set_parallel()
	tw.tween_property(sprite, "scale", Vector2.ONE, 0.25).set_ease(Tween.EASE_OUT)
	tw.tween_property(sprite, "position:y", 0, 0.25).set_ease(Tween.EASE_OUT)
	tw.tween_property(credit_card_sprite, "modulate:a", 1, 0.1).set_ease(Tween.EASE_OUT)
	tw.tween_property(credit_card_sprite, "position:y", -6, 0.25).set_ease(Tween.EASE_OUT)
	tw.tween_property(credit_card_sprite, "modulate:a", 0, 0.1).set_ease(Tween.EASE_OUT).set_delay(0.3)
