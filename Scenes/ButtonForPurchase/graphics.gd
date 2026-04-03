extends ButtonGraphics
class_name ButtonForPurchaseGraphics

@onready var purchase: PurchaseComponent = parent.purchase
var price_label: Label:
	get:
		if !price_label:
			price_label = get_node("LabelPrice")
		
		return price_label
var texture_progress_bar: TextureProgressBar:
	get:
		if !texture_progress_bar:
			texture_progress_bar = get_node("TextureProgressBar")
		
		return texture_progress_bar
		
func _ready() -> void:
	if parent:
		parent.button_hitted.connect(_on_button_hitted)
		parent.button_accepted.connect(_on_button_accepted)
		if purchase:
			purchase.price_updated.connect(_on_price_updated)
		
func _on_price_updated(new_p: int) -> void:
	if price_label:
		price_label.text = "%s%d" %[G.get_currency_sign(purchase.currency), new_p]

func _on_progress_updated(v: int) -> void:
	if texture_progress_bar:
		texture_progress_bar.value = v

func _on_button_hitted(v: int) -> void:
	texture_progress_bar.value = round(float(v) / float(parent.hit_buffer) * 100)

func _on_button_accepted() -> void:
	texture_progress_bar.value = 0
	
