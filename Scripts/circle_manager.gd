extends Node
class_name CircleManager

enum CircleTypes {
	NULL,
	TOMATO,
	CARROT,
	CHEST }

@onready var container: CircleContainer = G.get_n("circle_container")
@export var circle_list: Dictionary[CircleTypes, int] = {}
var circles_to_add: Array[CircleTypes] = []
var last_circle_list: Dictionary[CircleTypes, int] = {}
var stored_circles: Dictionary[CircleTypes, Array]
var spawned_circles: Dictionary[CircleTypes, Array]
@export var circles_on_table: int = 1:
	set(v):
		circles_on_table = v
		spawn_circles()

static var circle_data: Dictionary[CircleTypes, CircleData]

signal circle_spawned(type: CircleTypes)
signal circle_died(type: CircleTypes)

func _enter_tree() -> void:
	CircleController.manager = self
	ButtonShopCircleBuyController.circle_manager = self

func _ready() -> void:
	var k: Array = CircleTypes.keys()
	for i in range(1, CircleTypes.size()):
		spawned_circles[CircleTypes[k[i]]] = []
		stored_circles[CircleTypes[k[i]]] = []
	
	G.lvl_uped.connect(_on_lvl_uped)
	G.state_changed.connect(_on_state_changed)
	for i in circle_list:
		if circle_list[i] > 0:
			circles_to_add.append(i)
	
	spawn_circles()

func pick_circle() -> CircleTypes:
	if circles_to_add.size() < 1:
		return 0
		
	var target_circle: CircleTypes = circles_to_add.pick_random()
	if circle_list[target_circle] <= 0:
		return 0 
	
	return target_circle

func spawn_circle_at(_target_circle: CircleTypes = 0, global_pos: Vector2 = Vector2.ZERO, ignore_crate: bool = false) -> void:
	var target_circle: CircleTypes = _target_circle

	if G.game_state != G.GameStates.GAME:
		return
		
	if target_circle == 0:
		target_circle = pick_circle()
	
	if target_circle == 0:
		if ignore_crate:
			target_circle = 1
		else:
			return
	
	circle_spawned.emit(target_circle)
	await get_tree().create_timer(0.1).timeout
	if stored_circles[target_circle].size() > 0:
		stored_circles[target_circle][0].respawn_requested.emit()
		stored_circles[target_circle].remove_at(0)
	else:
		container.add_circle(target_circle, 6, global_pos)
	
	if !ignore_crate:
		remove_circle_from_crate(target_circle)

func spawn_circles(_target_circle: CircleTypes = 0, amount: int = 0) -> void:
	amount = max(0, circles_on_table - get_spawned_circle_amount()) if amount == 0 else amount
	prints("a", circles_on_table, get_spawned_circle_amount())
	for i in range(amount):
		var target_circle: CircleTypes = _target_circle

		if G.game_state != G.GameStates.GAME:
			break
			
		if target_circle == 0:
			target_circle = pick_circle()
		
		if target_circle == 0:
			break
		
		circle_spawned.emit(target_circle)
		remove_circle_from_crate(target_circle)
		await get_tree().create_timer(0.1).timeout
		if stored_circles[target_circle].size() > 0:
			stored_circles[target_circle][0].respawn_requested.emit()
			stored_circles[target_circle].remove_at(0)
		else:
			container.add_circle(target_circle)
		
		
func merge_circles(type: CircleTypes) -> bool:
	if CircleTypes.size()-1 < type + 1:
		return false
	
	var arr: Array = spawned_circles[type] if spawned_circles.has(type) else []
	if arr.size() < 2:
		return false
		
	var c1: Circle = arr[0]
	var c2: Circle = arr[1]
	c1.queue_free()
	c2.queue_free()
	arr.erase(c1)
	arr.erase(c2)
	
	container.add_circle(type+1)
	return true

func get_type_from_str(_str: String) -> CircleTypes:
	_str = _str.to_upper()
	for i in CircleTypes.keys():
		var pos: int = _str.find(i)
		if pos == -1:
			continue
		
		return CircleTypes[_str.substr(pos, i.length())]
	
	return CircleTypes.NULL

func get_circle_count(type: CircleTypes) -> int:
	if type == CircleTypes.NULL:
		return 0
		
	return spawned_circles.get(type).size()

func get_spawned_circle_amount() -> int:
	var v: int = 0
	for i in spawned_circles:
		v += spawned_circles[i].size()
	
	return v

func _on_lvl_uped() -> void:
	container.add_circle(CircleTypes.CHEST)

func store_or_delete_or_respawn(circle: Circle) -> String:
	#todo: probably doesn't work :P
	var type: CircleTypes = circle.type
	var new_c_type: CircleTypes = pick_circle()
	if circles_to_add.has(type) && get_spawned_circle_amount() <= circles_on_table:
		if new_c_type == type:
			remove_circle_from_crate(type)
			circle_spawned.emit(type)
			return "respawn"
		else:
			stored_circles[type].append(circle) 
			remove_from_spawned(circle)
			spawn_circles(new_c_type)
			return "store"
	else:
		remove_from_spawned(circle)
		spawn_circles(new_c_type)
		return "delete"

func remove_from_spawned(circle: Circle) -> void:
	var list_pointer: Array = spawned_circles[circle.type]
	if list_pointer.has(circle):
		list_pointer.erase(circle)

#func update_to_add_list(type: CircleTypes) -> void:
	#circle_list[type] -= 1
	#print(circle_list[type])
	#if circle_list[type] <= 0:
		#circles_to_add.erase(type)

func add_circles_to_crate(type: CircleTypes, amount: int) -> void:
	circle_list[type] += amount
	if !circles_to_add.has(type):
		circles_to_add.append(type)

func remove_circle_from_crate(type: CircleTypes, amount: int = 1) -> void:
	circle_list[type] = max(0, circle_list[type] - amount)
	if circle_list[type] == 0 && circles_to_add.has(type):
		circles_to_add.erase(type)

func _on_state_changed(state: G.GameStates) -> void:
	if state == G.GameStates.GAME:
		var t: Transition = G.get_n("transition")
		if t.playing:
			await t.transition_ended

		spawn_circles()
