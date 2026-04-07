extends Node

var tree: SceneTree

enum Currencies {
	DOLLAR,
	CIRCLE_WHITE,
	CIRCLE_RED
}
enum GameStates {
	GAME,
	MENU,
	CHEST,
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
signal chest_broken
signal chest_closed

func _input(event: InputEvent) -> void:
	if event is InputEventKey && event.is_pressed():
		if !tree:
			return
			
		match event.keycode:
			KEY_R:
				if !tree.current_scene:
					return
				
				tree.reload_current_scene()
			KEY_ESCAPE:
				tree.quit()

func get_n(_name: String) -> Node:
	return nodes.get(_name)

func setup_tw(tw: Tween) -> Tween:
	if tw:
		tw.kill()
	
	tw = create_tween()
	return tw

func add_shadow(shadow: Node2D) -> Node2D:
	var sg: CanvasGroup = nodes.get("shadow_group")
	if !sg:
		return Node2D.new()
		
	var new_s: Node2D = shadow.duplicate()
	new_s.global_position = shadow.global_position
	sg.add_child(new_s)
	shadow.queue_free()
	return new_s
