extends Node

var initial_time : int
var score : int = 0

@onready var hud: Hud = $HudLayer/Hud



func _ready() -> void:
	hud.set_score(score)
	hud.update_time()

func _on_field_head_hit(head: Head) -> void:
	print("died after : ", hud.get_current_timestamp(), " with score : ", score)
	get_tree().reload_current_scene.call_deferred()


func _on_food_spawner_food_eaten() -> void:
	score += 1
	hud.set_score(score)
