extends Node

var initial_time : int
var score : int = 0

@onready var hud: Hud = $HudLayer/Hud
@onready var end_screen: EndScreen = $UiLayer/EndScreen


func _ready() -> void:
	hud.set_score(score)
	hud.update_time()

func _on_field_head_hit(head: Head) -> void:
	end_screen.show_end_game_screen(score,hud.get_elapsed_time_str())


func _on_food_spawner_food_eaten() -> void:
	score += 1
	hud.set_score(score)
