extends ButtonForPurchaseGraphics
class_name ButtonCircleBuyGraphics

@onready var circle_sprite: Sprite2D = %CircleSprite
@onready var label_container: Control = $LabelContainer
@onready var label_pos: Vector2 = label_container.position
static var hidden_texture: Texture2D
var tw: Tween
var ttw: Tween

func _ready() -> void:
	super()
	purchase.purchased.connect(_on_purchased)
	set_texture(parent.available)
	parent.available_changed.connect(_on_available_changed)
	parent.returned.connect(_on_returned)
	G.state_changed.connect(_on_state_changed)

func _on_state_changed(state: G.GameStates) -> void:
	if state != G.GameStates.SHOP:
		if ttw:
			ttw.stop()
			ttw.kill()
	else:
		animate_price()
		
func animate_price() -> void:
	if parent.available || G.game_state != G.GameStates.SHOP:
		return
	
	if ttw:
		ttw.kill()
		
	ttw = create_tween()
	var sign_pool: Array[String] = ["#", "?", "1", "3", "$", "@", "!", "/", " "]
	var t: String = ""
	for i in range(randi_range(3, 4)):
		t += sign_pool.pick_random()
		
	ttw.tween_property(label_price, "text", t, 5).set_ease(Tween.EASE_IN_OUT)
	await ttw.finished
	animate_price()

func set_texture(available: bool) -> void:
	if available:
		circle_sprite.texture = G.circle_atlas_textures[parent.circle_type]
		modulate.a = 1
		_on_price_updated(purchase.price)
	else:
		circle_sprite.texture = hidden_texture
		modulate.a = 0.5
		
func _on_available_changed(available: bool) -> void:
	set_texture(available)

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
	
func _on_returned() -> void:
	if tw:
		tw.kill()
		
	tw = create_tween()
	circle_sprite.position.y = 0
	circle_sprite.scale = Vector2(0.46, 0.46)
	circle_sprite.modulate.a = 0.45
	label_container.position.y = label_pos.y
	label_container.scale = Vector2.ONE
	tw.set_parallel()
	tw.tween_property(circle_sprite, "scale", Vector2.ONE, 0.15).set_ease(Tween.EASE_IN)
	tw.tween_property(circle_sprite, "modulate:a", 1, 0.15).set_ease(Tween.EASE_IN)
	
