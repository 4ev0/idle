extends Control
class_name SaladProcess

@onready var progress_bar_mix: ProgressBar = $MarginContainer/VBoxContainer/ProgressBarMix
@onready var label_weight: Label = $MarginContainer/VBoxContainer/LabelWeight
@onready var bowl: Bowl = get_parent().get_node("Bowl")
@onready var salad_manager: SaladManager = G.get_n("salad_manager")
var weight: String = ""
var target_weight: String = ""

func _ready() -> void:
	bowl.mix_value_changed.connect(_on_mix_value_changed)
	salad_manager.weight_changed.connect(_on_weight_changed)
	salad_manager.target_changed.connect(_on_target_changed)
	progress_bar_mix.max_value = bowl.target_mix
	progress_bar_mix.value = bowl.mix_v
	
func _on_mix_value_changed(v: int) -> void:
	progress_bar_mix.value = v

func _on_weight_changed(v: int) -> void:
	weight = str(v)
	label_weight.text = "%s/%s" %[weight, target_weight]

func _on_target_changed(v: int) -> void:
	target_weight = str(v)
	label_weight.text = "%s/%s" %[weight, target_weight]
	
