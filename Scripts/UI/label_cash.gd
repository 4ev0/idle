extends RichTextLabel
class_name LabelCash

func _ready() -> void:
	G.cash_updated.connect(_on_cash_updated)
	
func _on_cash_updated(v: int) -> void:
	text = "$%d" %v
