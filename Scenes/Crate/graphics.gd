extends Node2D
class_name CrateGraphics

var tw: Tween

@onready var crate_front: Sprite2D = $CrateFront
@onready var crate_back: Sprite2D = $CrateBack
@onready var circle_container: Node2D = $CircleContainer
@onready var manager: CircleManager = G.get_n("circle_manager")

func _ready() -> void:
	manager.circle_spawned.connect(_on_circle_picked)

func _input(event: InputEvent) -> void:
	if event is InputEventKey && event.is_pressed() && event.keycode == KEY_Q:
		_on_circle_picked(1)

func _on_circle_picked(type: CircleManager.CircleTypes) -> void:
	if tw:
		tw.kill()
	
	var c: CrateCircleSprite = CrateCircleSprite.new()
	c.position.x = randi_range(-18,18) 
	c.texture = G.circle_atlas_textures[type]
	circle_container.add_child(c)
	tw = create_tween()
	scale = Vector2(0.9, 1.1)
	tw.set_parallel()
	tw.tween_property(self, "scale", Vector2.ONE, 0.15).set_ease(Tween.EASE_IN)

	
