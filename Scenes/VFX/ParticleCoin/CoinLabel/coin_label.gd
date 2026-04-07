extends Node2D
class_name CoinLabel

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label: Label = $Label

func _ready() -> void:
	animation_player.play("plus")
