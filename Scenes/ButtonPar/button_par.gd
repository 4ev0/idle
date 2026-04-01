extends Control
class_name ButtonPar

var graphics: ButtonGraphics
var controller: ButtonController
@export var currency: G.Currencies = G.Currencies.DOLLAR
var hit_buffer: int = 3
@export var max_price: int = 10:
	set(v):
		max_price = v
		if price != max_price:
			price = round(max_price / hit_buffer)
		
@onready var price: int = round(max_price / hit_buffer):
	set(v):
		price = v
		price_updated.emit(price)
		
var hitted: int = 0:
	set(v):
		var target_price: int = round(max_price / hit_buffer)
		if G.cash < price:
			return
		
		if v == hit_buffer:
			G.cash -= price
			hitted = 0
			buy()
		else:
			G.cash -= price
			price += target_price
			hitted = v
		
		progress_updated.emit(float(hitted) / float(hit_buffer) * 100)
			
signal price_updated(new_price: int)
signal progress_updated(v: float)

func _ready() -> void:
	await owner.ready
	price_updated.emit(price)

func buy() -> void:
	max_price += 20
	
