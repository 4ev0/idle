extends Node2D
class_name CircleContainer

@onready var manager: CircleManager = G.get_n("circle_manager")
var circle_scene: PackedScene = load("uid://dty5cnth88hfs")
var special_circle_scenes: Dictionary[CircleManager.CircleTypes, PackedScene] = {
	CircleManager.CircleTypes.CHEST : load("uid://1g7e6y7f6y6b")
}

signal circle_died

func add_circle(type: CircleManager.CircleTypes = CircleManager.CircleTypes.TOMATO, r: int = 6) -> void:
	if type == CircleManager.CircleTypes.NULL:
		return
		
	var scene: PackedScene = special_circle_scenes[type] if special_circle_scenes.has(type) else circle_scene
	var c: Circle = scene.instantiate()
	c.radius = r
	manager.spawned_circles[type].append(c)
	c.data = manager.circle_data[type]
	c.type = type
	add_child.call_deferred(c)

func remove_circle(circle: Circle) -> void:
	var arr: Array = manager.spawned_circles[circle.type]
	if arr.has(circle):
		arr.erase(circle)
	
