extends Node

var tree: SceneTree
var window: Window

enum Pickups {
	NULL,
	HANDSET,
	BOWL
}

enum Currencies {
	DOLLAR,
	CIRCLE_WHITE,
	CIRCLE_RED
}
enum GameStates {
	GAME,
	MENU,
	TELEPHONE_UPGRADE,
	SHOP,
}
enum CollisionLayers {
	NULL,
	CURSOR,
	DIAL_SUBMISSION
}
var nodes: Dictionary = {}
#var xp: int = 0:
	#set(v):
		#var target_xp: int = lvls[lvl]
		#xp = v % target_xp
		#nodes.progress_bar_level_up.value = xp
		#if v >= target_xp:
			#lvl += 1
			#lvl_uped.emit()
			#
#var lvl: int = 0:
	#set(v):
		#lvl = v
		#nodes.progress_bar_level_up.max_value = lvls[lvl]
		#
#var lvls: Array[int] = [100, 200, 300, 400, 500, 600, 700, 800]

var circle_atlas_textures: Dictionary = load("uid://d32wwffqfu8ui").textures

var strength: float = 10
var cash: int = 0:
	set(v):
		if v < cash && is_instance_valid(nodes.get("debug")):
			if nodes.debug.infinite_cash:
				v = cash
			
		cash = v
		cash_updated.emit(cash)

var tokens: int = 0:
	set(v):
		if v < tokens && is_instance_valid(nodes.get("debug")):
			if  nodes.debug.infinite_tokens:
				v = tokens
		
		tokens = v
		tokens_updated.emit(tokens)
		
var game_state: GameStates = GameStates.GAME:
	set(v):
		game_state = v
		state_changed.emit(game_state)
		print(GameStates.keys()[game_state])

var cursor_carrying: Pickups = Pickups.NULL:
	set(v):
		cursor_carrying = v
		if cursor_carrying == Pickups.NULL:
			cursor_freed.emit()

signal cash_updated(v: int)
signal tokens_updated(v: int)
signal main_ready
signal lvl_uped
signal chest_broken
signal chest_closed
signal state_changed(state: GameStates)
signal cursor_freed
signal salad_submitted

func _ready() -> void:
	ButtonCircleBuyGraphics.hidden_texture = load("uid://c1t58btrcikcl")

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

func add_shadow(shadow: Node2D) -> Node2D:
	var sg: CanvasGroup = nodes.get("shadow_group")
	if !sg:
		return Node2D.new()
		
	var new_s: Node2D = shadow.duplicate()
	new_s.global_position = shadow.global_position
	sg.add_child(new_s)
	shadow.queue_free()
	return new_s

func is_cursor_busy() -> bool:
	return cursor_carrying != Pickups.NULL

func set_cursor_carrying(pickup: Pickups, is_picked: bool) -> void:
	if is_picked:
		cursor_carrying = pickup
	else:
		if pickup == cursor_carrying:
			cursor_carrying = Pickups.NULL
