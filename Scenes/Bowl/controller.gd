extends Node2D
class_name BowlController

var parent: Bowl
var pickup_spoon: PickupComponent
var pickup: PickupComponent
@onready var drop_spot: DropSpot = G.get_n("drop_spot")
@onready var camera: Camera = G.get_n("camera")
@onready var bowl_left: float = parent.bowl_left
@onready var bowl_right: float = parent.bowl_right
@onready var max_y: float = pickup_spoon.position.y
var spoon_in: bool = false
var dir: int = 0:
	set(v):
		if v == dir:
			return

		if dir != 0 && v != 0 && parent.weight > 0:
			parent.add_mix()
		
		dir = v 

var ds_center_pos: Vector2 = Vector2.ZERO
var ds_half_width: float = 0

func _ready() -> void:
	pickup_spoon.sliced.connect(_on_spoon_sliced)
	pickup.sliced.connect(_on_sliced)
	parent.spoon_exited.connect(_on_spoon_exited)
	parent.mixed.connect(_on_mixed)
	check_mixed()
	G.salad_submitted.connect(_on_salad_submitted)
	
func check_mixed() -> void:
	if parent.mix_v < parent.target_mix:
		pickup.set_disabled(true)
		pickup_spoon.set_disabled(false)
	
func _on_mixed() -> void:
	pickup_spoon.set_disabled(true)
	pickup.set_disabled(false)
	
func _physics_process(delta: float) -> void:
	if spoon_in:
		var mouse_pos: Vector2 = get_local_mouse_position()
		match dir:
			0:
				if mouse_pos.x <= bowl_left || mouse_pos.x >= bowl_right:
					dir = -sign(mouse_pos.x)
			-1:
				if mouse_pos.x >= bowl_right:
					dir = 1
			1:
				if mouse_pos.x <= bowl_left:
					dir = -1
		
		if mouse_pos.y < max_y:
			change_spoon_state()

	%DebugLabel.text = "%0.2f\nasd0.2f" %[dir]
	if !parent.in_drop_spot() || !ds_center_pos || !ds_half_width:
		return
	
	var mouse_x: float = get_global_mouse_position().x
	var distance: float = clampf(abs(ds_center_pos.x - mouse_x) - 10, 1, ds_half_width)
	var ddir: int = -1 if abs(ds_center_pos.x) < abs(mouse_x) else 1
	parent.angle = deg_to_rad(180 - (180 / ((ds_half_width) / distance) * ddir))
	if parent.weight > 0:
		if parent.angle > deg_to_rad(90) && parent.angle < deg_to_rad(270):
			parent.weight -= 1
			drop_spot.weight -= 1
	
func _on_salad_submitted() -> void:
	set_physics_process(false)
	parent.angle = 0
	await drop_spot.change_animation_finished
	set_physics_process(true)
	
func _on_spoon_sliced() -> void:
	change_spoon_state()

func _on_spoon_exited() -> void:
	pickup_spoon.picked = false
	spoon_in = false
	await Engine.get_main_loop().process_frame
	dir = 0
	
func _on_sliced() -> void:
	var new_bowl_state: bool = !parent.is_picked()
	parent._bowl_picked = new_bowl_state
	G.set_cursor_carrying(G.Pickups.BOWL, new_bowl_state)
	
	if new_bowl_state:
		parent.bowl_picked.emit()
	else:
		parent.bowl_placed.emit()
		
func change_spoon_state(enabled: bool = !spoon_in) -> void:
	spoon_in = enabled
	if enabled:
		var mouse_x: float = get_local_mouse_position().x
		if abs(mouse_x) > 3:
			dir = sign(mouse_x)
		else:
			dir = 0
		
		parent.spoon_entered.emit()
	else:
		check_mixed()
		parent.spoon_exited.emit()
	
