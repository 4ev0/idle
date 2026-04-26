extends RichTextLabel
class_name LabelCash

@onready var init_pos: Vector2 = position
var tw: Tween

func _ready() -> void:
	G.cash_updated.connect(_on_cash_updated)
	
func _on_cash_updated(v: int) -> void:
	var target_text: String = "$%d" %v
	if int(text.substr(1, -1)) > v:
		if tw:
			tw.kill()
		
		tw = create_tween()
		pivot_offset = size / 2
		scale = Vector2(0.85, 1.2)
		position.y = init_pos.y - 2
		tw.set_parallel()
		tw.tween_property(self, "scale", Vector2.ONE, 0.15).set_ease(Tween.EASE_IN_OUT)
		tw.tween_property(self, "position:y", init_pos.y, 0.25).set_ease(Tween.EASE_IN_OUT)
		tw.tween_property(self, "text", target_text, 0.55).set_ease(Tween.EASE_OUT)
	else:
		text = target_text
