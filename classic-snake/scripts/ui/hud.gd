extends Control
class_name Hud

var initial_time : int

@onready var time_manager: TimeManager = $TimeManager
@onready var time_label: Label = $HSplitContainer/HBoxContainer2/TimeLabel
@onready var score_label: Label = $HSplitContainer/HBoxContainer/ScoreLabel


func _ready() -> void:
	initial_time = Time.get_ticks_msec()


func set_score(score : int) -> void:
	score_label.text = "x"+str(score)


func get_elapsed_time_str() -> String:
	return time_label.text.replace("time : ","")

func update_time() -> void:
	time_label.text = "time : "+str(get_current_timestamp())


func get_current_timestamp() -> String:
	return time_manager.get_time_stamp(Time.get_ticks_msec()-initial_time)


func _on_display_time_timer_timeout() -> void:
	time_label.text = "time : "+str(get_current_timestamp())
