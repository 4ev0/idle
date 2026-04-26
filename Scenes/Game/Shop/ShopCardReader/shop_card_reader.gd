extends Node2D
class_name ShopCardReader

var product_manager: ShopProductManager:
	get:
		if !product_manager:
			product_manager = G.get_n("shop_product_manager")
		
		return product_manager
