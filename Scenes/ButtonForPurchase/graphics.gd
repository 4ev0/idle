extends ButtonGraphicsProgress
class_name ButtonForPurchaseGraphics

@onready var purchase: PurchaseComponent = parent.purchase
@onready var label_price: Label = %LabelPrice

func _ready() -> void:
	super()
	if purchase:
		purchase.price_updated.connect(_on_price_updated)

func _on_price_updated(new_p: int) -> void:
	if label_price:
		label_price.text = "%s%d" %[purchase.get_currency_sign(), new_p]
