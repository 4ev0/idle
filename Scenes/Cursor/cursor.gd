extends Node2D
class_name Cursor

var graphics: CursorGraphics
var velocity: Vector2 = Vector2.ZERO
@onready var prev_mouse_pos: Vector2 = get_global_mouse_position()
var dir: Vector2 = Vector2.ZERO
@onready var area: Area2D = $Area2D

func _ready() -> void:
	G.nodes.get("visual_controller").toggle_cursor.connect(_on_cursor_toggled)
	await G.main_ready
	G.window.focus_exited.connect(_on_focus_exited)
	G.window.focus_entered.connect(_on_focus_entered)
	
func _on_focus_entered() -> void:
	area.monitorable = true
	
func _on_focus_exited() -> void:
	area.monitorable = false

func _on_cursor_toggled(enabled: bool) -> void:
	graphics.visible = enabled
	var mm: Input.MouseMode = Input.MOUSE_MODE_HIDDEN if enabled else Input.MOUSE_MODE_VISIBLE
	Input.set_mouse_mode(mm)

func _enter_tree() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _physics_process(delta: float) -> void:
	var mouse_pos: Vector2 = get_global_mouse_position()
	global_position = mouse_pos

	velocity = prev_mouse_pos - mouse_pos
	prev_mouse_pos = mouse_pos

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		dir = event.relative
