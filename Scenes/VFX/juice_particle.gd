extends CPUParticles2D
class_name JuiceParticle

@onready var timer = $Timer

func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	
func _on_timer_timeout() -> void:
	set_process(false)
	set_physics_process(false)
	set_process_internal(false)
