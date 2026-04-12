extends Area2D
class_name DialButtonArea

static var controller: TelephoneDialController
@onready var number: int = int(name)
@onready var collision: CollisionShape2D = $CollisionShape2D

signal button_entered(number: int)
signal submission_entered(number: int)

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	
func _on_area_entered(area: Area2D) -> void:
	if !area is DialButtonArea:
		match area.collision_layer:
			G.CollisionLayers.CURSOR:
				button_entered.emit(number)
			G.CollisionLayers.DIAL_SUBMISSION:
				submission_entered.emit(number)
			
