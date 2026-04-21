extends RichTextLabel
class_name LabelTokens

func _ready() -> void:
	G.tokens_updated.connect(_on_tokens_updated)
	
func _on_tokens_updated(v: int) -> void:
	text = "O%d" %v
