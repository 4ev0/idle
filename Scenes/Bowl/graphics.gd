extends Node2D

const EXITED_SPOON_HEIGHT: float = -31

var parent: Bowl
@onready var cursor: Cursor = G.get_n("cursor")
@onready var spoon_sprite: Sprite2D = $SpoonContainer/Spoon
@onready var spoon_frame_count: int = spoon_sprite.hframes - 1
@onready var bowl_sprite: Sprite2D = $Bowl
@onready var bowl_left: float = parent.bowl_left
@onready var bowl_right: float = parent.bowl_right
@onready var sprite_step: float = abs(bowl_left - bowl_right) / (spoon_frame_count + 1)
var spoon_in: bool = false
var tw: Tween
var tw2: Tween

func _ready() -> void:
	parent.spoon_entered.connect(_on_spoon_entered)
	parent.spoon_exited.connect(_on_spoon_exited)
	parent.bowl_placed.connect(_on_bowl_placed)
	spoon_sprite.modulate.a = 0
	spoon_sprite.position.y = EXITED_SPOON_HEIGHT
	parent.mixed.connect(_on_mixed)
	
func _physics_process(delta: float) -> void:
	if spoon_in:
		spoon_sprite.position.x = lerpf(spoon_sprite.position.x, clampf(get_local_mouse_position().x, bowl_left, bowl_right), 0.3)
		spoon_sprite.frame = clampi(floor((spoon_sprite.position.x - bowl_left) / sprite_step), 0, spoon_frame_count) 
		bowl_sprite.rotation = lerp_angle(bowl_sprite.rotation, deg_to_rad(clampf(cursor.dir.x * cursor.velocity.length() / 3, -15, 15)), 0.3)
	else:
		if parent.is_picked():
			bowl_sprite.global_position = get_global_mouse_position()

		if !parent.in_drop_spot():
			if abs(bowl_sprite.rotation) <= 0:
				return

			bowl_sprite.rotation = lerp_angle(bowl_sprite.rotation, 0, 0.3)
		else:
			bowl_sprite.rotation = lerp_angle(bowl_sprite.rotation, parent.angle, 0.5) 
	
func _on_spoon_entered() -> void:
	spoon_in = true
	if tw:
		tw.kill()
		
	tw = create_tween()
	tw.set_parallel()
	
	spoon_sprite.position.x = clampf(get_local_mouse_position().x, bowl_left, bowl_right)
	spoon_sprite.position.y = EXITED_SPOON_HEIGHT
	tw.tween_property(spoon_sprite, "position:y", 0, 0.25).set_ease(Tween.EASE_OUT)
	tw.tween_property(spoon_sprite, "modulate:a", 1, 0.15).set_ease(Tween.EASE_OUT)

func _on_spoon_exited() -> void:
	spoon_in = false
	if tw:
		tw.kill()
		
	tw = create_tween()
	tw.set_parallel()
	tw.tween_property(spoon_sprite, "position:y", EXITED_SPOON_HEIGHT, 0.25).set_ease(Tween.EASE_OUT)
	tw.tween_property(spoon_sprite, "modulate:a", 0, 0.15).set_ease(Tween.EASE_OUT)
	
func _on_mixed() -> void:
	if tw2:
		tw2.kill()
		
	tw2 = create_tween()
	spoon_sprite.position.y = -8
	bowl_sprite.position.y = -4
	bowl_sprite.scale = Vector2(0.8, 1.1)
	tw2.set_parallel()
	tw2.tween_property(bowl_sprite, "position:y", 0, 0.35).set_ease(Tween.EASE_IN)
	tw2.tween_property(spoon_sprite, "position:y", 0, 0.35).set_ease(Tween.EASE_IN)
	tw2.tween_property(bowl_sprite, "scale", Vector2.ONE, 0.35).set_ease(Tween.EASE_IN_OUT)

func _on_bowl_placed() -> void:
	if tw2:
		tw2.kill()
		
	tw2 = create_tween()
	bowl_sprite.rotation = sign(bowl_sprite.position).x * deg_to_rad(cursor.velocity.length())
	tw2.tween_property(bowl_sprite, "position", Vector2.ZERO, 0.35).set_ease(Tween.EASE_IN)
