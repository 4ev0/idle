extends CanvasLayer
class_name LayerChestScreen

@onready var button_chest_skip: ButtonPar = %ButtonChestSkip

func _ready() -> void:
	change_game_state()
	G.chest_broken.connect(Callable(func() -> void: show()))
	G.chest_closed.connect(Callable(func() -> void: hide()))
	visibility_changed.connect(_on_visibility_changed)
	
func _on_visibility_changed() -> void:
	change_game_state()

func change_game_state() -> void:
	G.game_state = G.GameStates.CHEST if visible else G.GameStates.GAME
	button_chest_skip.set_hitted(0)
