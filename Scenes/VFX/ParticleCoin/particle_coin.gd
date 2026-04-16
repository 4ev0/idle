extends Particle
class_name ParticleCoin

@onready var shadow: Node2D = $Shadow
@onready var sprite: Sprite2D = $CoinSilver
@onready var depth: Sprite2D = $Depth
var coin_label_scene: PackedScene = load("uid://cxaaqmn6mts8a")
static var label_container: CoinLabelContainer

var spin_spd: float = 8
var spin: bool = true
var scale_b: float = 0.7
var ttw: Tween

func _ready() -> void:
	shadow = G.add_shadow(shadow)
	tw = create_tween()
	sprite.scale = Vector2.ZERO
	tw.set_parallel()
	tw.tween_property(sprite, "scale:x", 0.9, 0.3).set_ease(Tween.EASE_IN)
	tw.tween_property(sprite, "position:y", -25, 0.3).set_ease(Tween.EASE_OUT)
	tw.tween_property(sprite, "position:y", 0, 0.35).set_ease(Tween.EASE_IN).set_delay(0.53)
	tw.tween_property(sprite, "scale:x", 0.35, 0.35).set_ease(Tween.EASE_IN).set_delay(0.5)
	tw.tween_property(self, "scale_b", 1.2, 0.35).set_ease(Tween.EASE_IN).set_delay(0.53)
	
	tw.set_parallel(false)
	tw.tween_callback(func() -> void:
		spin = false
		sprite.flip_v = false
		sprite.scale = Vector2(1.2, 0.6)
		depth.position = Vector2.ZERO
		depth.hide()
		shadow.scale = Vector2(0.8, 0.8))
	tw.tween_property(sprite, "scale", Vector2(0.8, 0.8), 0.15).set_ease(Tween.EASE_OUT)
	
	
	tw.tween_callback(func() -> void: sprite.scale = Vector2(0.5, 1)).set_delay(0.25)
	tw.tween_property(sprite, "scale", Vector2(0.35,0.1), 0.09).set_ease(Tween.EASE_OUT)
	tw.tween_callback(func() -> void:
		delete())
	
	#tw.set_parallel()
	#var wait: float = randf_range(1.3, 1.6)
	#var wait2: float = wait - 0.8
	#tw.tween_property(sprite, "position:y", -65, 0.5).set_ease(Tween.EASE_IN).set_delay(wait2)
	#tw.tween_property(sprite, "scale:y", randf_range(0.6, 0.7), 0.15).set_ease(Tween.EASE_OUT).set_delay(wait2)
	#tw.tween_property(sprite, "position:y", 0, 0.5).set_ease(Tween.EASE_IN).set_delay(wait2 + 0.5)
	#ttw.tween_property(self, "position", G.get_n("cash_marker").global_position , 1).set_ease(Tween.EASE_OUT).set_delay(wait)
	 #+ Vector2(randf_range(5, 30), randf_range(5, 30))
	
func _physics_process(delta: float) -> void:
	shadow.scale = sprite.scale
	if !spin:
		return
		
	sprite.scale.y = wrapf(sprite.scale.y + spin_spd * delta, -scale_b, scale_b)
	
	depth.scale = sprite.scale
	depth.position = sprite.position + Vector2(0, [0, 1][int(sprite.scale.y < 0)])

func delete() -> void:
	var cl: CoinLabel = coin_label_scene.instantiate()
	cl.global_position = global_position
	if label_container:
		label_container.add_child(cl)
		
	G.cash += 10
	shadow.queue_free()
	queue_free()
	
