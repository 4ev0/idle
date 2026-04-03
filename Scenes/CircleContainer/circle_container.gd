extends Node2D
class_name CircleContainer

enum CircleTypes {
	NULL,
	WHITE,
	RED,
	CHEST }

@export var circle_data: Dictionary[CircleTypes, Resource]
var special_circle_scenes: Dictionary[CircleTypes, PackedScene] = {
	CircleTypes.CHEST : load("uid://1g7e6y7f6y6b")
}
var circle_scene: PackedScene = load("uid://dty5cnth88hfs")
var circles: Dictionary[CircleTypes, Array]

func _ready() -> void:
	var k: Array = CircleTypes.keys()
	for i in range(1, CircleTypes.size()):
		circles[CircleTypes[k[i]]] = []
	
	G.lvl_uped.connect(_on_lvl_uped)
	add_circle()
	
func add_circle(type: CircleTypes = CircleTypes.WHITE, r: int = 8) -> void:
	if type == CircleTypes.NULL:
		return
		
	var scene: PackedScene = special_circle_scenes[type] if special_circle_scenes.has(type) else circle_scene
	var c: Circle = scene.instantiate()
	c.radius = r
	circles[type].append(c)
	c.data = circle_data[type]
	add_child.call_deferred(c)

func merge_circles(type: CircleTypes) -> bool:
	if CircleTypes.size()-1 < type + 1:
		return false
		
	var arr: Array = circles[type]
	if arr.size() < 2:
		return false
		
	var c1: Circle = arr[0]
	var c2: Circle = arr[1]
	c1.queue_free()
	c2.queue_free()
	arr.erase(c1)
	arr.erase(c2)
	
	add_circle(type+1)
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
		
	return circles.get(type).size()

func _on_lvl_uped() -> void:
	add_circle(CircleTypes.CHEST)
