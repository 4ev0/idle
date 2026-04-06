extends ButtonGraphics
class_name ButtonGraphicsProgress

@export var progress_bar: TextureProgressBar

func _ready() -> void:
	if !progress_bar:
		for c in get_children():
			if !c is TextureProgressBar:
				continue
			
			progress_bar = c
	
	if !progress_bar:
		return

	super()
	
func _on_button_hitted(v: int) -> void:
	progress_bar.value = round(float(v) / float(parent.hit_buffer) * 100)

func _on_button_accepted() -> void:
	progress_bar.value = 0
