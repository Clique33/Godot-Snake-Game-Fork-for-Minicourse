extends Control
class_name EndScreen

@onready var final_score_message: Label = $VBoxContainer/FinalScoreMessage
@onready var final_time_message: Label = $VBoxContainer/FinalTimeMessage

func show_end_game_screen(score : int, elapsed_time_str : String) -> void:
	final_score_message.text = "Score: " + str(score)
	final_time_message.text = "Time: " + elapsed_time_str
	show()
	get_tree().paused = true

func _input(event: InputEvent) -> void:
	if event.is_action_released("restart") and visible:
		#print("died after : ", hud.get_current_timestamp(), " with score : ", score)
		get_tree().reload_current_scene.call_deferred()
		get_tree().paused = false
