extends Control
class_name ShrinkingContainer

@onready var control: Control = $Control
var dy: float = 0
var ty: float = 0

func _physics_process(delta: float) -> void:
	var prev_size_y: float = 0
	var prev_sc_y: float = 1
	var prev_pos_y: float = 0
	var pos_y: float = 0
	control.position.y -= delta * 10
	#control.position.y = get_local_mouse_position().y
	for i in control.get_children():
		i.position.y = (prev_sc_y * prev_size_y) + prev_pos_y
		pos_y += prev_size_y
		var y: float = control.position.y
		var sy: float = i.size.y
		if i.name == "ProgressBarQuest2":
			d(pos_y + prev_pos_y + sy + y, y)
		
		prev_pos_y = i.position.y
		if y < 1:
			if floor(i.position.y) == 0:
				#if i is ProgressBar:
					#print(pos_y)
				i.scale.y = clampf(1 - (abs(y) - pos_y) / sy, 0, 1)
		
		i.position.y += abs(y)
		prev_size_y = sy
		prev_sc_y = i.scale.y

func d(y: float, y2: float) -> void:
	dy = y
	ty = y2
	queue_redraw()

func _draw() -> void:
	var p: Vector2 = Vector2(122, dy)
	draw_circle(p, 1, Color.RED)
	draw_string(get_theme_default_font(), p, "\n %0.02f\n %0.02f" %[dy, ty])
