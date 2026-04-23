extends Node2D
class_name Telephone

var max_handset_y: int = -15
var handset_y: float = 0:
	set(v):
		if v == max_handset_y:
			handset_y = 0
			picked = false
			G.game_state = G.GameStates.TELEPHONE_UPGRADE
			telephone_used.emit()
		else:
			handset_y = v
			
var handset_offset_y: float = 0
@onready var target_rotation: float = deg_to_rad(-18) 
var picked: bool = false:
	set(v):
		picked = v
		G.set_cursor_carrying(G.Pickups.HANDSET, picked)
		if picked:
			handset_picked.emit()

signal telephone_used
signal handset_picked
