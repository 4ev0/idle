extends Node
class_name RoomChangeManager

@export var initial_room: Room
@onready var camera: Camera = G.get_n("camera")
@onready var cursor: Cursor = G.get_n("cursor")
@onready var timer: Timer = $Timer
@onready var timer_buffer: Timer = $TimerBuffer
var rooms: Dictionary[Room, Array] = {}
var mouse_pos: Vector2 = Vector2.ZERO
var tw: Tween

signal change_requested(target_room: Room, parent_room: Room)

func _ready() -> void:
	RoomChanger.manager = self
	change_requested.connect(_on_change_requested)
	camera.global_position = initial_room.global_position
	timer.timeout.connect(_on_timeout)
	timer_buffer.timeout.connect(_on_buffer_timeout)
	await G.main_ready
	for c in rooms[initial_room]:
		c.set_disabled(false)
		
	await Engine.get_main_loop().process_frame
	camera.position_smoothing_enabled = true
	
func _on_change_requested(target_room: Room, parent_room: Room) -> void:
	if G.is_cursor_busy():
		return
		
	if !timer_buffer.is_stopped():
		timer_buffer.stop()
		
	if mouse_pos:
		if parent_room.get_local_mouse_position().distance_to(mouse_pos) < 25:
			mouse_pos = Vector2.ZERO
			return
	
	mouse_pos = parent_room.get_local_mouse_position()
	for c in rooms[parent_room]:
		c.set_disabled(true)
	
	cursor.set_disabled(true)
	timer.start()
	var target_pos: Vector2 = target_room.position
	var parent_pos: Vector2 = parent_room.position
	if tw:
		tw.kill()
	
	tw = create_tween()
	tw.tween_property(camera, "position", target_pos, 0.18).set_ease(Tween.EASE_OUT)
	await tw.finished
	if !rooms.has(target_room):
		return
	
	for c in rooms[target_room]:
		c.set_disabled(false)

func register(changer: RoomChanger, parent_room: Room) -> void:
	if !rooms.has(parent_room):
		rooms[parent_room] = []
		
	rooms[parent_room].append(changer)
	
func _on_timeout() -> void:
	cursor.set_disabled(false)
	timer_buffer.start()

func _on_buffer_timeout() -> void:
	#todo: came up with a better solution
	if mouse_pos:
		mouse_pos = Vector2.ZERO
