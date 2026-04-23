extends Node2D
class_name TelephoneExitController

var pickup: PickupComponent
var parent: TelephoneExit
@onready var exit_y: float = parent.marker_exit.position.y
@onready var min_y: float = position.y - $Pickup/CollisionShape2D.shape.size.y / 2 - 1
@onready var min_x: float = -$Pickup/CollisionShape2D.shape.size.x / 2

func _ready() -> void:
	set_physics_process(false)
	pickup.sliced.connect(_on_sliced)
	
func _physics_process(delta: float) -> void:
	var mouse_pos: Vector2 = get_local_mouse_position()
	var mouse_y: float = mouse_pos.y
	$Label.text = "%0.2v" %mouse_pos
	if mouse_y <= min_y || mouse_pos.x < min_x || mouse_pos.x > -min_x :
		place()
		
	if mouse_y > exit_y:
		place()
		G.game_state = G.GameStates.GAME
		
func place() -> void:
		set_physics_process(false)
		G.set_cursor_carrying(G.Pickups.EXIT_HANDSET, false)
		pickup.picked = false
		
func _on_sliced() -> void:
	var pp: bool = pickup.picked
	if pp:
		set_physics_process(true)
	else:
		set_physics_process(false)
		
	G.set_cursor_carrying(G.Pickups.EXIT_HANDSET, pp)
		
