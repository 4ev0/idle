extends ButtonForPurchaseController

func _on_button_accepted() -> void:
	super()
	var ck: CircleContainer = parent.circle_container
	if ck:
		ck.add_circle(ck.CircleTypes.WHITE)
