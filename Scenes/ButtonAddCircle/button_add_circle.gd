extends ButtonPar
class_name ButtonAddCircle

@onready var circle_container: CircleContainer = G.get_n("circle_container")

func buy() -> void:
	super()
	circle_container.add_circle(circle_container.CircleTypes.WHITE)
