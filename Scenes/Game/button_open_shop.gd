extends Button
class_name ButtonOpenShop

@onready var shop: StateChanger = %Shop
@onready var factory: StateChanger = %Factory
@onready var telephone_upgrade: StateChanger = %TelephoneUpgrade

func _pressed() -> void:
	var t: Transition = G.get_n("transition")
	if t:
		match G.game_state:
			G.GameStates.GAME:
				t._show(shop, factory)
			G.GameStates.SHOP:
				t._show(factory, shop)
