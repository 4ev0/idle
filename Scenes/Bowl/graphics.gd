extends Node2D

const EXITED_SPOON_HEIGHT: float = -24
var parent: Bowl
@onready var spoon_sprite: Sprite2D = $Spoon
@onready var bowl_left: float = $BowlLeft.global_position.y
@onready var bowl_right: float = $BowlRight.global_position.y
var spoon_in: bool = false
var tw: Tween

func _ready() -> void:
	parent.spoon_entered.connect(_on_spoon_entered)
	parent.spoon_exited.connect(_on_spoon_exited)
	spoon_sprite.modulate.a = 0
	spoon_sprite.position.y = EXITED_SPOON_HEIGHT

func _physics_process(delta: float) -> void:
	if !spoon_in:
		return
	
	#spoon_sprite.position.x = clampf(get_global_mouse_position().x, bowl_left, bowl_right) 

func _on_spoon_entered() -> void:
	spoon_in = true
	if tw:
		tw.kill()
		
	tw = create_tween()
	tw.set_parallel()
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
	
