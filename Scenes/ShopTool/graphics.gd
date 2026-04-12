extends Node2D
class_name ShopToolGraphics

var parent: ShopTool
@onready var tool_sprite: Sprite2D = %ToolSprite
@onready var shop_tool_palm: Sprite2D = %ShopToolPalm
@onready var palm_container: Node2D = $PalmContainer
var picked: bool = false

func _ready() -> void:	
	parent.picked.connect(_on_picked)
	parent.placed.connect(_on_placed)
	
func _physics_process(delta: float) -> void:
	if !picked:
		return
		
	tool_sprite.global_position = get_global_mouse_position()
	
func _on_picked() -> void:
	picked = true
	shop_tool_palm.frame = 1

func _on_placed() -> void:
	picked = false
	shop_tool_palm.frame = 0
	tool_sprite.position = Vector2.ZERO	
	
