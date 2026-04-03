extends CanvasLayer
class_name LayerChestScreen

func _ready() -> void:
	change_game_state()
	visibility_changed.connect(_on_visibility_changed)
	
func _on_visibility_changed() -> void:
	change_game_state()

func change_game_state() -> void:
	G.game_state = G.GameStates.MENU if visible else G.GameStates.GAME
	
