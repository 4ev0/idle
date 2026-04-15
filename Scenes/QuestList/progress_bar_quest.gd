extends ProgressBar

@onready var label: Label = $Label

func _ready() -> void:
	value_changed.connect(_on_value_changed)
	_on_value_changed()
	
func _on_value_changed(v: float = value) -> void:
	label.text = "%d/%d (%d%%)" %[value, max_value, int(value * 100 / max_value)]
