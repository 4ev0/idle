extends StateChanger

@onready var telephone_dial: TelephoneDial = $TelephoneDial

func _ready() -> void:
	super()
	var t: Telephone = G.get_n("telephone")
	if t:
		t.handset_picked.connect(_on_telephone_picked)

func _on_visibility_changed() -> void:
	super()
	telephone_dial.disabled = !visible
	
func _on_telephone_picked() -> void:
	factory.hide()
	telephone_dial.disabled = false
	show()
	
