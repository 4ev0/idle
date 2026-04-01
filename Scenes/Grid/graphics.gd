extends Node2D
class_name GridGraphics

var parent: Grid
@export var __draw: bool = true:
	set(v):
		__draw = v
		queue_redraw()
			

func _draw() -> void:
	if !__draw:
		return
		
	var rr: Rect2 = parent.reference_rect.get_rect()
	var cv: Array = parent.cells.values()
	for xx in range(cv.size()):
		for yy in range(cv[xx].size()):
			draw_rect(Rect2(rr.position + Vector2(xx * 16, yy * 16), Vector2(16,16)) , Color.WHITE, false)
