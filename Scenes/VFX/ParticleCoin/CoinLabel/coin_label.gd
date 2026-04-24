extends Node2D
class_name CoinLabel

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label: Label = $Label
var v: int = 0

func _ready() -> void:
	label.text = "+%d$" %v
	animation_player.play("plus")
