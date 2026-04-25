extends Node2D
class_name ShopCrate

@onready var product_manager: ShopProductManager = %ShopProductManager
@onready var sprite: Sprite2D = $ShopCrateSprite
@onready var purchase_particle: CratePurchaseParticle = $ParticleContainer/CratePurchaseParticle
@onready var return_particle: CratePurchaseParticle = $ParticleContainer/CrateReturnParticle
@onready var free_purchase_particles: Array[CratePurchaseParticle] = [purchase_particle]
@onready var free_return_particles: Array[CratePurchaseParticle] = [return_particle]
@onready var particle_container: Node2D = $ParticleContainer
var particle_amount: int = 0
var tw: Tween

func _enter_tree() -> void:
	CratePurchaseParticle.parent = self

func _ready() -> void:
	hide()
	product_manager.purchased.connect(_on_product_purchased)
	product_manager.returned.connect(_on_product_returned)
	sprite.modulate.a = 0
	
func _on_product_returned(_amount: int, type: CircleManager.CircleTypes) -> void:
	spawn_particle(_amount, type, "return")
	
func spawn_particle(_amount: int, type: CircleManager.CircleTypes, particle_type: String) -> void:
	if _amount <= 0:
		return
		
	if particle_amount > 100:
		return
		
	var p: CratePurchaseParticle
	match particle_type:
		"purchase":
			if free_purchase_particles.size() > 0:
				p = free_purchase_particles[0]
				free_purchase_particles.remove_at(0)
			else:
				p = purchase_particle.duplicate()
				particle_container.add_child(p)
		"return":
			if free_return_particles.size() > 0:
				p = free_return_particles[0]
				free_return_particles.remove_at(0)
			else:
				p = return_particle.duplicate()
				particle_container.add_child(p)
			
	p.amount = _amount
	particle_amount += _amount
	p.texture = G.circle_atlas_textures[type]
	p.play()
	
func _on_product_purchased(amount: int, type: CircleManager.CircleTypes) -> void:
	if !visible:
		show()
		if tw:
			tw.kill()
			
		tw = create_tween()
		sprite.position.y = 20
		sprite.scale = Vector2(0.9, 1.1)
		tw.set_parallel()
		tw.tween_property(sprite, "modulate:a", 1, 0.1).set_ease(Tween.EASE_IN_OUT)
		tw.tween_property(sprite, "position:y", -8, 0.2).set_ease(Tween.EASE_IN)
		tw.tween_property(sprite, "scale", Vector2(0.85, 1.15), 0.5).set_ease(Tween.EASE_IN_OUT)
		#tw.tween_property(sprite, "scale", Vector2(0.8, 1.2), 0.15).set_ease(Tween.EASE_OUT).set_delay(0.27)
		tw.tween_property(sprite, "position:y", 0, 0.15).set_ease(Tween.EASE_OUT).set_delay(0.27)
		tw.tween_callback(func() -> void: sprite.scale = Vector2(1.05,0.95)).set_delay(0.42)
		tw.tween_property(sprite, "scale", Vector2.ONE, 0.25).set_ease(Tween.EASE_IN_OUT).set_delay(0.42)
	
	spawn_particle(amount, type, "purchase")
		
