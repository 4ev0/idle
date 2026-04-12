extends Node2D
class_name TelephoneDialGraphics

var parent: TelephoneDial
@onready var camera: Camera = G.get_n("camera")
@onready var telephone_dial: Sprite2D = $TelephoneDial
@onready var telephone_pointer: Sprite2D = $TelephonePointer
@onready var cursor: Cursor = G.get_n("cursor")
@onready var button_container: Node2D = %ButtonContainer
var tw: Tween

func _ready() -> void:
	parent.button_submitted.connect(_on_button_submitted)
	
func _on_button_submitted() -> void:
	if tw:
		tw.kill()
		
	tw = create_tween()
	var ang: float = max(5.5, min(10, cursor.velocity.length()) * 3.5)
	telephone_pointer.rotation = deg_to_rad(-ang)
	tw.tween_property(telephone_pointer, "rotation", 0, 0.25).set_ease(Tween.EASE_IN).set_delay(0.06)
	if camera:
		camera.shake(min(10, cursor.velocity.length() / 2), 0.1)

func _physics_process(delta: float) -> void:
	var r: float = button_container.rotation
	if telephone_dial.rotation != r:
		telephone_dial.rotation = button_container.rotation
	
