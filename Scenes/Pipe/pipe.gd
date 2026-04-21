extends Node2D
class_name Pipe

var controller: PipeController
var graphics: PipeGraphics
@onready var capsule_container: CapsuleContainer = $CapsuleContainer

signal lever_pulled

func is_capsule_in() -> bool:
	return capsule_container.capsule_quests.active
