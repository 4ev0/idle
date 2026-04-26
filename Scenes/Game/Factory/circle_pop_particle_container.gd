extends Node2D
class_name CirclePopParticleContainer

func _enter_tree() -> void:
	CircleGraphics.pop_particle_container = self
	
func add_particle(_color: Color, pos: Vector2) -> void:
	var e: EffectPop = EffectPop.new()
	e.color = _color
	e.global_position = pos
	add_child(e)
