extends CanvasLayer
class_name Transition

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var playing: bool = false:
	set(v):
		if playing && !v:
			transition_ended.emit()
			
		playing = v
var animation: String:
	get:
		return animation_player.current_animation

signal transition_ended

func default() -> void:
	play_in()
	await animation_player.animation_finished
	play_out()

func play_in() -> void:
	animation_player.play("transition_in")
	playing = true
	
func play_out() -> void:
	animation_player.play("transition_out")
	playing = true
	
# todo: remove visibility change from transition
func _show(to_show: Node, to_hide: Node = null) -> void:
	play_in()
	await animation_player.animation_finished
	to_show.show()
	if to_hide:
		to_hide.hide()
		
	play_out()
	await animation_player.animation_finished
	playing = false
