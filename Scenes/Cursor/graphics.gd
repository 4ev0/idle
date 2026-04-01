extends Node2D
class_name CursorGraphics

@onready var sprite: Sprite2D = $Cursor
var parent: Cursor

func _physics_process(delta: float) -> void:
	scale.x = 1 + abs(parent.velocity.x) * 0.1
	scale.y = 1 - abs(parent.velocity.x) * 0.01
	
	rotation = parent.velocity.angle()
	
func _draw() -> void:
	draw_circle(Vector2.ZERO, 3, Color.BLACK, true)
	draw_circle(Vector2.ZERO, 2, Color.WHITE, true)
