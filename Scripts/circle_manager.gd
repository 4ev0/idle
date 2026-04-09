extends Node
class_name CircleManager

enum CircleTypes {
	NULL,
	TOMATO,
	RED,
	CHEST }

@onready var container: CircleContainer = G.get_n("circle_container")
@export var circle_list: Dictionary[CircleTypes, int] = {}
var circles_to_add: Array[CircleTypes] = [CircleTypes.TOMATO]
var last_circle_list: Dictionary[CircleTypes, int] = {}
@export var circle_data: Dictionary[CircleTypes, Resource]
var stored_circles: Dictionary[CircleTypes, Array]
var spawned_circles: Dictionary[CircleTypes, Array]

signal circle_spawned(type: CircleTypes)

func _ready() -> void:
	var k: Array = CircleTypes.keys()
	for i in range(1, CircleTypes.size()):
		spawned_circles[CircleTypes[k[i]]] = []
		stored_circles[CircleTypes[k[i]]] = []
	
	G.lvl_uped.connect(_on_lvl_uped)
	await G.main_ready
	spawn_circles()

func pick_circle() -> CircleTypes:
	if circles_to_add.size() < 1:
		return 0
		
	var target_circle: CircleTypes = circles_to_add.pick_random()
	if circle_list[target_circle] <= 0:
		return 0 
	
	return target_circle

func spawn_circles(target_circle: CircleTypes = 0) -> void:
	for i in range(G.circles_on_table):
		if target_circle == 0:
			target_circle = pick_circle()
		
		if target_circle == 0:
			return
		
		circle_spawned.emit(target_circle)
		await get_tree().create_timer(0.1).timeout
		if stored_circles[target_circle].size() > 0:
			stored_circles[target_circle][0].respawn_requested.emit()
			stored_circles[target_circle].remove_at(0)
		else:
			container.add_circle(target_circle)
		
		update_to_add_list(target_circle)
		
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

func _on_lvl_uped() -> void:
	container.add_circle(CircleTypes.CHEST)

func store_or_delete_or_respawn(circle: Circle) -> String:
	#todo: probably doesn't work :P
	var type: CircleTypes = circle.type
	if circles_to_add.has(type):
		var new_c_type: CircleTypes = pick_circle()
		if new_c_type == type:
			update_to_add_list(type)
			circle_spawned.emit(type)
			return "respawn"
		else:
			stored_circles[type].append(circle) 
			spawn_circles(new_c_type)
			return "store"
	else:
		return "delete"

func update_to_add_list(type: CircleTypes) -> void:
	circle_list[type] -= 1
	if circle_list[type] <= 0:
		circles_to_add.erase(type)
