extends Node2D
class_name TokerContainer

@onready var tree: SceneTree = G.tree
var token_scene: PackedScene = load("uid://bfy0hy66hqmtm")

func _enter_tree() -> void:
	CapsuleTokenController.container = self

func add_tokens(amount: int, pos: Vector2) -> void:
	for i in amount:
		var t: Token = token_scene.instantiate()
		t.spawn_pos = pos + Vector2(randf_range(1, 8), randf_range(1, 8)).rotated(deg_to_rad(randf_range(0, 360)))
		t.global_position = pos
		add_child(t)
		var delay: float = [0, 0.02, 0.03].pick_random()
		#if delay > 0:
		await tree.create_timer(randf_range(0.01, 0.03)).timeout
		
		
