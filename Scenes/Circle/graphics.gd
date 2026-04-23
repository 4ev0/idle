extends Node2D
class_name CircleGraphics

var parent: Circle
@onready var sprite: Sprite2D = $Sprite
@onready var sprite_shadow: Sprite2D = $SpriteShadow
var juice_particle_scene: PackedScene = load("uid://b6gitxgsj51kg")
static var slice_particle_container: CircleSliceParticleContainer
static var pop_particle_container: CirclePopParticleContainer

var tw: Tween
var stw: Tween

@onready var hit_circle: HitCircle

func _ready() -> void:
	var type: CircleManager.CircleTypes = parent.type
	sprite.texture = G.circle_atlas_textures[type].duplicate()
	sprite_shadow.texture = sprite.texture
	parent.frame_count = G.circle_frames[type]
	
	parent.sliced.connect(_on_sliced)
	parent.spawned.connect(_on_spawned)
	parent.died.connect(_on_died)
	parent.frame_updated.connect(_on_frame_updated)
	
func _on_frame_updated(f: int) -> void:
	sprite.texture.region.position = Vector2(0, 16 * f)
	if f == parent.frame_count || f == 0:
		return
		
	tw = setup_tw(tw)
	stw = setup_tw(stw)
	
	sprite.scale = Vector2(0.75, 1.2)
	sprite_shadow.scale = Vector2(0.8, 1)
	sprite.position = Vector2(0, -3)
	tw.tween_property(sprite, "scale", Vector2.ONE, 0.15).set_ease(Tween.EASE_IN_OUT)
	stw.tween_property(sprite_shadow, "scale", Vector2.ONE, 0.23).set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(sprite, "position", Vector2.ZERO, 0.23).set_ease(Tween.EASE_IN_OUT)
	slice_particle_container.add_particle(parent.type, f, parent.global_position)
	
func _on_sliced(mouse_pos: Vector2) -> void:
	if parent.value >= parent.data.hp:
		return
	
	spawn_juice()
	var hc: HitCircle = HitCircle.new()
	hc.global_position = global_position.direction_to(mouse_pos) * parent.radius
	add_child(hc)

func _on_spawned() -> void:
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
	pop_particle_container.add_particle(parent.data.paritcle_color, global_position)

func spawn_juice() -> void:
	var group = G.get_n("juice_group")
	if group:
		var p: JuiceParticle = juice_particle_scene.instantiate()
		p.modulate = parent.data.paritcle_color
		p.direction = global_position.direction_to(get_global_mouse_position())
		p.global_position = global_position
		group.add_child(p)
