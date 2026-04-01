extends Node

enum Currencies {
	DOLLAR,
	CIRCLE_WHITE,
	CIRCLE_RED
}

var nodes: Dictionary = {}
var strength: float = 10
var cash: int = 0:
	set(v):
		cash = v
		cash_updated.emit(cash)

signal cash_updated(v: int)

func _input(event: InputEvent) -> void:
	if event is InputEventKey && event.is_pressed():
		match event.keycode:
			KEY_R:
				get_tree().reload_current_scene()
			KEY_ESCAPE:
				get_tree().quit()

func get_n(_name: String) -> Node:
	return nodes.get(_name)

func get_currecny(type: Currencies) -> int:
	match type:
		Currencies.DOLLAR:
			return cash
		_:
			var ck: CircleContainer = nodes.get("circle_container")
			if ck:
				return ck.get_circle_count(ck.get_type_from_str(Currencies.keys()[type]))
	
	return 0
	

	
