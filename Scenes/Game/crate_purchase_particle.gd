extends GPUParticles2D
class_name CratePurchaseParticle

@export_enum("purchase", "return") var type: String

static var parent: ShopCrate

func play() -> void:
	emitting = true
	restart()
	await finished
	parent.particle_amount -= amount
	if type == "purchase":
		parent.free_purchase_particles.push_back(self)
	else:
		parent.free_return_particles.push_back(self)
		
