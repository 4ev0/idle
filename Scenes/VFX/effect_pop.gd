extends Node2D
class_name EffectPop

@export var lines: int = 3
var r: bool = true
var color: Color

func _ready() -> void:
	var space: float = TAU / lines
	var rotation_offset: float = deg_to_rad(randf_range(-90, 90))
	add_child(ParticleCircleFlash.new())
	for i in range(lines):
		var pl: ParticleLines = ParticleLines.new()
		pl.modulate = color
		if r:
			pl.rotation = space * (i + 1) - rotation_offset
			#pl.r = r
			
		add_child(pl)
