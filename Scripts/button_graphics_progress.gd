extends ButtonGraphics
class_name ButtonGraphicsProgress

@export var progress_bar_button: TextureProgressBar

func _ready() -> void:
	if !progress_bar_button:
		for c in get_children():
			if !c is TextureProgressBar:
				continue
			
			progress_bar_button = c
	
	if !progress_bar_button:
		return

	super()
	
func _on_button_hitted(v: int) -> void:
	progress_bar_button.value = round(float(v) / float(parent.hit_buffer) * 100)

func _on_button_accepted() -> void:
	progress_bar_button.value = 0
