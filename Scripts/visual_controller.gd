extends Node
class_name VisualController

@export var custom_cursor: bool = true:
	set(v):
		custom_cursor = v 
		toggle_cursor.emit(custom_cursor)

signal toggle_cursor(enabled: bool)

func _ready() -> void:
	await owner.ready
	toggle_cursor.emit(custom_cursor)
