extends Control
class_name SaladProcess

@onready var progress_bar_mix: ProgressBar = $MarginContainer/VBoxContainer/ProgressBarMix
@onready var label_weight: Label = $MarginContainer/VBoxContainer/LabelWeight
@onready var bowl: Bowl = get_parent().get_node("Bowl")
var bowl_weight: String = ""
var bowl_max_weight: String = ""

func _ready() -> void:
	bowl.mix_value_changed.connect(_on_mix_value_changed)
	bowl.weight_changed.connect(_on_bowl_weight_changed)
	bowl.max_weight_changed.connect(_on_bowl_max_weight_changed)
	progress_bar_mix.max_value = bowl.target_mix
	progress_bar_mix.value = bowl.mix_v
	
func _on_mix_value_changed(v: int) -> void:
	progress_bar_mix.value = v

func _on_bowl_weight_changed(v: int) -> void:
	bowl_weight = str(v)
	label_weight.text = "%s/%s" %[bowl_weight, bowl_max_weight]

func _on_bowl_max_weight_changed(v: int) -> void:
	bowl_max_weight = str(v)
	label_weight.text = "%s/%s" %[bowl_weight, bowl_max_weight]
	
