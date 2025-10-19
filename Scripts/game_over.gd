extends Control
class_name GameOverScreen

@onready var game_over_time: Label = $VBoxContainer/GameOverTime
@onready var game_over_score: Label = $VBoxContainer/GameOverScore
@onready var lose: AudioStreamPlayer = $Lose

func make_screen_appear():
	show()
	lose.play()
	

func set_time_and_score(time : String, score : int) -> void:
	game_over_time.text = "TIME: " + time
	game_over_score.text = "SCORE: " + str(score)
