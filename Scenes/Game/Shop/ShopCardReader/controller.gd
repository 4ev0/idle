extends Node2D
class_name ShopCardReaderController

var sliceable: Sliceable
var parent: ShopCardReader

func _ready() -> void:
	sliceable.sliced.connect(_on_sliced)
	var pm: ShopProductManager = parent.product_manager
	pm.res_cash_setted.connect(_on_res_cash_setted)
	pm.res_cash_unsetted.connect(_on_res_cash_unsetted)
	
func _on_res_cash_setted() -> void:
	sliceable.set_disabled(false)

func _on_res_cash_unsetted() -> void:
	sliceable.set_disabled(true)
	
func _on_sliced() -> void:
	parent.product_manager.pay()
