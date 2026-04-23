extends Node2D
class_name TelephoneDialController

var parent: TelephoneDial
@onready var cursor: Cursor = G.get_n("cursor")
@onready var dial_area: Area2D = $DialArea
@onready var dial_collision: CollisionShape2D = dial_area.get_node("CollisionShape2D")
@onready var button_container: Node2D = $ButtonContainer
@onready var submission_area: Area2D = $SubmissionArea
var init_mouse_pos: Vector2
var button_number: int = -1
var tw: Tween

func _ready() -> void:
	set_physics_process(false)
	DialButtonArea.controller = self
	for a in button_container.get_children():
		if a is DialButtonArea:
			a.button_entered.connect(_on_button_area_entered)
			a.submission_entered.connect(_on_submission_area_entered)
	
	dial_area.area_exited.connect(_on_dial_area_exited)
	parent.disable.connect(_on_disabled)
	
func _physics_process(delta: float) -> void:
	var ang: float = init_mouse_pos.angle_to(get_local_mouse_position())
	button_container.rotation = ang
	#queue_redraw()

func _on_button_area_entered(number: int) -> void:
	if G.game_state != G.GameStates.TELEPHONE_UPGRADE:
		return
		
	if parent.focused:
		return

	if tw:
		tw.kill()
	
	button_number = number
	parent.focused = true
	set_physics_process(true)
	button_container.rotation = 0
	init_mouse_pos = get_local_mouse_position()

func _on_submission_area_entered(number: int) -> void:
	if button_number != -1 && button_number == number:
		parent.button_submitted.emit()
		rotate_back()
		
func _on_dial_area_exited(area: Area2D) -> void:
	if !parent.focused:
		return
		
	rotate_back()

func rotate_back() -> void:
	set_physics_process(false)
	button_number = -1
	set_buttons_disabled(true)
	if tw:
		tw.kill()
		
	tw = create_tween()
	var t: float = abs(button_container.rotation * 0.35)
	tw.tween_property(button_container, "rotation", 0, t).set_ease(Tween.EASE_IN_OUT)
	tw.tween_callback(func() -> void: 
		parent.focused = false
		set_buttons_disabled(false))

func _on_disabled(enabled: bool) -> void:
	set_buttons_disabled(enabled)
	dial_collision.call_deferred("set_disabled", enabled)

func set_buttons_disabled(enabled: bool) -> void:
	for b in button_container.get_children():
		if b is DialButtonArea:
			b.collision.call_deferred("set_disabled", enabled)

#func _draw() -> void:
	#draw_line(init_mouse_pos, init_mouse_pos * 2, Color.WHITE)
	#draw_arc(init_mouse_pos, 6, init_mouse_pos.angle(), init_mouse_pos.angle_to(get_local_mouse_position()), 20, Color.YELLOW)
	#draw_line(init_mouse_pos, get_local_mouse_position(), Color.RED)
