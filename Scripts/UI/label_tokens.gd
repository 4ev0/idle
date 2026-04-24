extends RichTextLabel
class_name LabelTokens

@onready var marker_pos: Vector2 = $MarkerCollector.global_position
@onready var camera: Camera = G.get_n("camera")
@onready var collection_pos: Vector2:
	get:
		return camera.global_position - Vector2(160, 90) + marker_pos

var tw: Tween

func _enter_tree() -> void:
	Token.label_tokens = self

func _ready() -> void:
	G.tokens_updated.connect(_on_tokens_updated)
	
func _on_tokens_updated(v: int) -> void:
	pivot_offset = size / 2
	text = "O%d" %v
	if tw:
		tw.kill()
		
	scale = Vector2(0.91, 1.2)
	tw = create_tween()
	tw.tween_property(self, "scale", Vector2.ONE, 0.25)
	
