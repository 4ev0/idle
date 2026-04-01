extends Node2D
class_name Cursor

var graphics: CursorGraphics
var velocity: Vector2 = Vector2.ZERO
@onready var prev_mouse_pos: Vector2 = get_global_mouse_position()
var dir: Vector2 = Vector2.ZERO

func _ready() -> void:
	G.nodes.get("visual_controller").toggle_cursor.connect(_on_cursor_toggled)

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
