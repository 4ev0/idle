extends Node2D
class_name ShopToolGraphics

var parent: ShopTool
@onready var tool_sprite: Sprite2D = %ToolSprite
@onready var shop_tool_palm: Sprite2D = %ShopToolPalm
@onready var palm_container: Node2D = $PalmContainer
@onready var palm_container_pos: Vector2 = palm_container.position

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var picked: bool = false
var tw: Tween
var ttw: Tween

func _ready() -> void:	
	parent.picked.connect(_on_picked)
	parent.placed.connect(_on_placed)
	parent.appear_required.connect(_on_appear_required)
	
func _on_appear_required() -> void:
	animation_player.play("appear")
	
func _physics_process(delta: float) -> void:
	if !picked:
		return
		
	tool_sprite.global_position = get_global_mouse_position()
	
func _on_picked() -> void:
	picked = true
	if tw:
		tw.kill()
		
	tw = create_tween()
	tw.set_parallel()
	palm_container.position.y = palm_container_pos.y - 3
	palm_container.scale = Vector2(0.7, 1.2)
	tw.tween_property(palm_container, "position:y", palm_container_pos.y, 0.35).set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(palm_container, "scale", Vector2.ONE, 0.45).set_ease(Tween.EASE_IN_OUT)
	
	shop_tool_palm.frame = 1

func _on_placed() -> void:
	picked = false
	if ttw:
		ttw.kill()
	if tw:
		tw.kill()
		
	tw = create_tween()
	ttw = create_tween()
	tw.set_parallel()
	palm_container.position.y = palm_container_pos.y + 3
	tool_sprite.position = Vector2(0, 4)
	palm_container.scale = Vector2(1.2, 0.7)
	tw.tween_property(palm_container, "position:y", palm_container_pos.y, 0.35).set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(palm_container, "scale", Vector2.ONE, 0.45).set_ease(Tween.EASE_IN_OUT)
	ttw.tween_property(tool_sprite, "position:y", 0, 0.35).set_ease(Tween.EASE_IN_OUT)

	shop_tool_palm.frame = 0
