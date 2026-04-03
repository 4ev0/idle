extends Node

enum Currencies {
	DOLLAR,
	CIRCLE_WHITE,
	CIRCLE_RED
}
enum GameStates {
	GAME,
	MENU,
}

var nodes: Dictionary = {}
var xp: int = 0:
	set(v):
		var target_xp: int = lvls[lvl]
		xp = v % target_xp
		nodes.progress_bar_level_up.value = xp
		if v >= target_xp:
			lvl += 1
			lvl_uped.emit()
			
var lvl: int = 0:
	set(v):
		lvl = v
		nodes.progress_bar_level_up.max_value = lvls[lvl]
		
var lvls: Array[int] = [100, 200, 300, 400, 500, 600, 700, 800]
		
var strength: float = 10
var cash: int = 0:
	set(v):
		cash = v
		cash_updated.emit(cash)

var game_state: GameStates = GameStates.GAME:
	set(v):
		game_state = v
		print(GameStates.keys()[game_state])

signal cash_updated(v: int)
signal main_ready
signal lvl_uped

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
	
func get_currency_sign(type: Currencies) -> String:
	match type:
		Currencies.DOLLAR:
			return "$"
		_:
			return "o"
	
	return ""
		
	
