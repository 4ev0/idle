extends Node2D
class_name CircleGraphics

var parent: Circle
@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar
@onready var texture_scale: Vector2 = texture_progress_bar.size
@onready var sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var sprite_shadow: Node2D = get_node("AnimatedSprite2D2")
@onready var gpu_particles_2d: GPUParticles2D = get_node("GPUParticles2D")
@onready var particles: Dictionary = {1 : get_node("GPUParticles2D"), 2 : get_node("GPUParticles2D2") }

var slide_particle_scene: PackedScene = load("uid://b6gitxgsj51kg")

var tw: Tween
var stw: Tween

@onready var hit_circle: HitCircle

func _ready() -> void:
	parent.value_updated.connect(_on_value_updated)

	parent.sliced.connect(_on_sliced)
	parent.spawned.connect(_on_spawned)
	parent.died.connect(_on_died)

func _on_value_updated(new_v: float) -> void:
	#todo: make more beautiful 
	var vv: float = parent.data.hp - (parent.data.hp / (sprite.sprite_frames.get_frame_count("default") - sprite.frame))
	if new_v <= vv:
		sprite.frame += vv / new_v 
		tw = setup_tw(tw)
		stw = setup_tw(stw)
		
		sprite.scale = Vector2(0.75, 1.2)
		sprite_shadow.scale = Vector2(0.8, 1)
		sprite.position = Vector2(0, -3)
		tw.tween_property(sprite, "scale", Vector2.ONE, 0.15).set_ease(Tween.EASE_IN_OUT)
		stw.tween_property(sprite_shadow, "scale", Vector2.ONE, 0.23).set_ease(Tween.EASE_IN_OUT)
		tw.tween_property(sprite, "position", Vector2.ZERO, 0.23).set_ease(Tween.EASE_IN_OUT)
		var p: GPUParticles2D = particles.get(sprite.frame) #todo: spawn particles outside of an object
		if p:
			p.restart()
			p.emitting = true
		
	sprite_shadow.frame = sprite.frame

func _on_sliced(mouse_pos: Vector2) -> void:
	if parent.value >= parent.data.hp:
		return
		
	spawn_juice()
	var hc: HitCircle = HitCircle.new()
	hc.global_position += global_position.direction_to(mouse_pos) * parent.radius
	add_child(hc)

func _on_spawned() -> void:
	sprite.frame = 0
	tw = setup_tw(tw)
	stw = setup_tw(stw)
	
	sprite.position = Vector2(0, -8)
	sprite.scale = Vector2(0.6, 1.3)
	sprite_shadow.scale = Vector2(0.6, 0.8)
	tw.tween_property(sprite, "position", Vector2(0, 2), 0.17).set_ease(Tween.EASE_IN)
	tw.tween_property(sprite, "scale", Vector2(1.15, 0.75), 0.08).set_ease(Tween.EASE_IN_OUT)
	tw.tween_callback(func() -> void: 
		tw.set_parallel()
		stw.set_parallel())
	tw.tween_property(sprite, "position", Vector2.ZERO, 0.09).set_ease(Tween.EASE_OUT)
	tw.tween_property(sprite, "scale", Vector2.ONE, 0.06).set_ease(Tween.EASE_IN_OUT)

	stw.tween_property(sprite_shadow, "position", Vector2(1, 3), 0.17).set_ease(Tween.EASE_IN)
	stw.tween_property(sprite_shadow, "scale", Vector2(1.15, 0.75), 0.08).set_ease(Tween.EASE_IN_OUT)
	stw.tween_property(sprite_shadow, "position", Vector2(1,2), 0.09).set_ease(Tween.EASE_IN)
	stw.tween_property(sprite_shadow, "scale", Vector2.ONE, 0.06).set_ease(Tween.EASE_IN_OUT)

func setup_tw(target: Tween) -> Tween:
	if target:
		target.kill()
		
	target = create_tween()
	return target

func _on_died() -> void:
	var e: EffectPop = EffectPop.new()
	e.color = Color("#b91d1d")
	e.global_position = global_position
	G.get_n("main").add_child(e)

func spawn_juice() -> void:
	var group = G.get_n("juice_group")
	if group:
		var p: JuiceParticle = slide_particle_scene.instantiate()
		p.modulate = Color("#b91d1d")
		p.direction = global_position.direction_to(get_global_mouse_position())
		p.global_position = global_position
		group.add_child(p)
