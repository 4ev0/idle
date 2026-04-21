extends Node2D
class_name Cursor

var graphics: CursorGraphics
var velocity: Vector2 = Vector2.ZERO
@onready var prev_mouse_pos: Vector2 = get_global_mouse_position()
var dir: Vector2 = Vector2.ZERO
@onready var area: Area2D = $Area2D
@onready var collision: CollisionShape2D = $Area2D/CollisionShape2D
var query: PhysicsShapeQueryParameters2D = PhysicsShapeQueryParameters2D.new()

func _ready() -> void:
	query.shape = SeparationRayShape2D.new()
	query.collide_with_areas = true
	query.collide_with_bodies = false
	query.exclude = [area.get_rid()]
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

func set_disabled(enabled: bool) -> void:
	collision.set_deferred("disabled", enabled)

func _physics_process(delta: float) -> void:
	var mouse_pos: Vector2 = get_global_mouse_position()
	global_position = mouse_pos
	dir = prev_mouse_pos.direction_to(mouse_pos)

	velocity = prev_mouse_pos - mouse_pos
	if Input.is_action_pressed("disable_cursor"):
		prev_mouse_pos = mouse_pos
		return
		
	if mouse_pos.distance_to(prev_mouse_pos) > 1:
		if area.monitorable && !collision.disabled:
			var length: float = velocity.length()
			query.shape.length = length
			query.transform.origin = mouse_pos
			query.transform = query.transform.looking_at(prev_mouse_pos)
			query.transform = query.transform.rotated_local(-PI/2)
			for result in get_world_2d().direct_space_state.intersect_shape(query):
				var collider: CollisionObject2D = result.collider
				if collider is Sliceable:
					if collider.min_velocity <= length:
						collider.slice()
					else:
						print(length)

	prev_mouse_pos = mouse_pos
