extends Node
class_name QuestManager

var quests: Dictionary = {}
var cutted: Dictionary[CircleManager.CircleTypes, Dictionary] = {}
var default_reward: Callable = Callable(func(q: Quest) -> void: prints("completed", q._name))

signal quest_completed

class Quest:
	var description: String = ""
	var _name: String = ""
	var data: Dictionary = {}
	var completed: bool = false:
		set(v):
			if completed && v:
				return
				
			completed = v
			if completed:
				quest_completed.emit(self)
				
	signal quest_completed(quest: Quest)
	
	func _init(n: String, d: String) -> void:
		description = d
		_name = n

func new_cut_quest(n: String, d: String, target_v: int, circle_type: CircleManager.CircleTypes, reward: Callable = default_reward) -> Quest:
	var q: Quest = Quest.new(n, d)
	q.data["target_value"] = target_v
	q.quest_completed.connect(reward)
	cutted[circle_type].connected_quests.append(q)
	return q
	
func _ready() -> void:
	for i in range(1, CircleManager.CircleTypes.size()):
		cutted[i] = {"v" : 0, "connected_quests" : []}
	
	quests["50tomato"] = new_cut_quest("50tomato", "cut 50 tomatoes", 50, CircleManager.CircleTypes.TOMATO, 
	Callable(func(q: Quest) -> void: 
		G.get_n("shop_product_manager").change_product_state(CircleManager.CircleTypes.TOMATO, 10)
		))
	
func count_cutted(type: CircleManager.CircleTypes) -> void:
	var point: Dictionary = cutted[type]
	point.v += 1
	for q in point.connected_quests:
		if q.completed:
			continue
		
		if q.data.target_value <= point.v:
			complete(q)
		
func complete(quest: Quest) -> void:
	quest.completed = true
	quest_completed.emit()
