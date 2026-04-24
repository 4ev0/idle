extends Particle
class_name ParticleCoin

@onready var shadow: Node2D = $Shadow
@onready var sprite: Sprite2D = $CoinSilver
@onready var depth: Sprite2D = $Depth
var coin_label_scene: PackedScene = load("uid://cxaaqmn6mts8a")
var value: int = 0
var spin_spd: float = 8
var spin: bool = true
var scale_b: float = 0.7
var spin_tw: Tween

static var label_container: CoinLabelContainer
static var grid: Grid

func _ready() -> void:
	shadow = G.add_shadow(shadow)
	shadow.scale = Vector2.ZERO
	sprite.scale = Vector2.ZERO
	depth.scale = Vector2.ZERO
	tw = create_tween()
	tw.set_parallel()
	tw.tween_property(sprite, "scale:x", 0.9, 0.3).set_ease(Tween.EASE_IN)
	tw.tween_property(sprite, "position:y", -25, 0.3).set_ease(Tween.EASE_OUT)
	tw.tween_callback(func() -> void:
		if !grid.is_cell_free(grid.get_cell_coords(global_position)):
			play_death_anim(true, 0.12)
			
		sprite.z_index = 2).set_delay(0.4)
	tw.tween_property(sprite, "position:y", 0, 0.35).set_ease(Tween.EASE_IN).set_delay(0.53)
	tw.tween_property(sprite, "scale:x", 0.35, 0.35).set_ease(Tween.EASE_IN).set_delay(0.5)
	tw.tween_property(self, "scale_b", 1.2, 0.35).set_ease(Tween.EASE_IN).set_delay(0.53)
	await tw.finished
	play_death_anim()

func play_death_anim(_spin: bool = false, delay: float = 0) -> void:
	if tw:
		tw.kill()
		
	tw = create_tween()
	spin = _spin
	sprite.flip_v = false
	depth.position = Vector2.ZERO
	depth.hide()
	shadow.scale = Vector2(0.8, 0.8)
	if spin:
		if spin_tw:
			spin_tw.kill()
			
		spin_tw = create_tween()
		spin_tw.tween_property(self, "spin_spd", 2, 0.5)
	if !spin:
		sprite.scale = Vector2(1.2, 0.6)
		tw.tween_property(sprite, "scale", Vector2(0.8, 0.8), 0.15).set_ease(Tween.EASE_OUT)
		
	tw.tween_callback(func() -> void: sprite.scale = Vector2(0.5, 1)).set_delay(delay + 0.25)
	tw.tween_property(sprite, "scale", Vector2(0.35,0.1), 0.09).set_ease(Tween.EASE_OUT)
	tw.tween_callback(func() -> void:
		delete())
	
func _physics_process(delta: float) -> void:
	shadow.scale = sprite.scale
	if !spin:
		return
		
	sprite.scale.y = wrapf(sprite.scale.y + spin_spd * delta, -scale_b, scale_b)
	
	depth.scale = sprite.scale
	depth.position = sprite.position + Vector2(0, [0, 1][int(sprite.scale.y < 0)])

func delete() -> void:
	var cl: CoinLabel = coin_label_scene.instantiate()
	cl.global_position = sprite.global_position
	cl.v = value
	if label_container:
		label_container.add_child(cl)
		
	G.cash += value
	shadow.queue_free()
	queue_free()
	
