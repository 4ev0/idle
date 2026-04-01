extends Control
class_name ButtonGraphics

var parent: ButtonPar
var price_label: Label:
	get:
		if !price_label:
			price_label = get_node("LabelPrice")
		
		return price_label
var texture_progress_bar: TextureProgressBar:
	get:
		if !texture_progress_bar:
			texture_progress_bar = get_node("TextureProgressBar")
		
		return texture_progress_bar
		


func _ready() -> void:
	if parent:
		parent.price_updated.connect(_on_price_updated)
		parent.progress_updated.connect(_on_progress_updated)
		
func _on_price_updated(new_p: int) -> void:
	if price_label:
		price_label.text = "%d" %new_p

func _on_progress_updated(v: int) -> void:
	print("a = %0.2f" %v)
	if texture_progress_bar:
		texture_progress_bar.value = v
	
	
	
