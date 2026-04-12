extends Node2D
class_name PipeGraphics

var parent: Pipe
@onready var pipe: Sprite2D = $Pipe
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var camera: Camera = G.get_n("camera")

func _ready() -> void:
	parent.lever_pulled.connect(_on_lever_pulled)
	
func _on_lever_pulled() -> void:
	if !animation_player.is_playing():
		animation_player.play("pull")

func shake_cam() -> void:
	if camera:
		camera.shake(1, 0.1)
	
