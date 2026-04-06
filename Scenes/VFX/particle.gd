extends Node2D
class_name Particle

var tw: Tween

func setup_tw() -> void:
	if tw:
		tw.kill()
		
	tw = create_tween()

func kill() -> void:
	await tw.finished
	queue_free()
