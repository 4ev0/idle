extends Node2D
class_name SliceParticle

@export var type: CircleManager.CircleTypes
@export var repeat_last: bool = false
@export var max_repeat: int = 0
var particles: Dictionary[int, GPUParticles2D] = {}
static var container: CircleSliceParticleContainer

func _ready() -> void:
	z_index = 2
	for i in get_children():
		particles[int(i.name)] = i
		
func force_restart() -> void:
	for i in get_children():
		if i.emitting:
			i.restart()
		
func play(stage: int) -> void:
	var target_particle
	if !particles.has(stage):
		if !repeat_last || stage > max_repeat:
			return
		else:
			target_particle = particles[particles.keys()[-1]]
		
	var particle: GPUParticles2D = particles[stage] if !target_particle else target_particle
	particle.restart()
	await particle.finished
	container.on_particle_freed(self)
	
