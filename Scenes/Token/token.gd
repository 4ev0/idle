extends Node2D
class_name Token

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
var spawn_pos: Vector2 = Vector2.ZERO
var spd :float = 1
var value: int = 1
var tw: Tween

static var label_tokens: LabelTokens

func _ready() -> void:
	set_physics_process(false)
	tw = create_tween()
	sprite.scale = Vector2.ZERO
	tw.set_parallel()
	tw.tween_property(sprite, "scale", Vector2.ONE, 0.15).set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(sprite, "global_position", spawn_pos, 0.2).set_ease(Tween.EASE_OUT)
	tw.tween_property(sprite, "modulate:a", 0, 0.25).set_delay(0.5)
	await tw.finished
	G.tokens += value
	queue_free()
	
	#await get_tree().create_timer(0.85).timeout
	#set_physics_process(true)
#
#func _physics_process(delta: float) -> void:
	#var target_pos: Vector2 = label_tokens.collection_pos
	#spd = lerpf(spd, 180, 0.35)
	#global_position += global_position.direction_to(target_pos) * spd * delta
	#if global_position.distance_to(target_pos) < 2:
		#G.tokens += value
		#queue_free()
		#set_physics_process(false)
