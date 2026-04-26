extends Node2D
class_name CircleSliceParticleContainer

var particle_scenes: Dictionary = load("uid://dsv1xvj714ci7").particle_scenes
var free_particles: Dictionary[CircleManager.CircleTypes, Array] = {}

func _enter_tree() -> void:
	CircleGraphics.slice_particle_container = self
	SliceParticle.container = self

func _ready() -> void:
	for i in range(1, CircleManager.CircleTypes.size()):
		free_particles[i] = []
	
	for i in get_children():
		if i is SliceParticle:
			free_particles[i.type].append(i)
	
func add_particle(circle_type: CircleManager.CircleTypes, stage: int, pos: Vector2) -> void:
	if !particle_scenes.has(circle_type) || !particle_scenes.get(circle_type):
		return
		
	var p: SliceParticle
	if free_particles[circle_type].size() > 0:
		p = free_particles[circle_type][0]
		p.global_position = pos
		free_particles[circle_type].remove_at(0)
	else:
		p = particle_scenes[circle_type].instantiate()
		p.global_position = pos
		add_child(p)
		
	p.play(stage)

func on_particle_freed(particle: SliceParticle) -> void:
	free_particles[particle.type].push_back(particle)
	
