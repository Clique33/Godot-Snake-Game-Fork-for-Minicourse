extends Node

var initial_time : int
var score : int = 0

@onready var time_manager: TimeManager = $TimeManager
@onready var display_time_timer: Timer = $TimeManager/DisplayTimeTimer
@onready var score_label: Label = $ScoreLabel
@onready var time_label: Label = $TimeLabel


func _ready() -> void:
	initial_time = Time.get_ticks_msec()
	score_label.text = "score : "+str(score)
	time_label.text = "time : "+str(get_current_timestamp())

func _on_field_head_hit(head: Head) -> void:
	print("died after : ", get_current_timestamp(), " with score : ", score)
	get_tree().reload_current_scene.call_deferred()


func _on_food_spawner_food_eaten() -> void:
	score += 1
	score_label.text = "score : "+str(score)


func _on_display_time_timer_timeout() -> void:
	time_label.text = "time : "+str(get_current_timestamp())


func get_current_timestamp() -> String:
	return time_manager.get_time_stamp(Time.get_ticks_msec()-initial_time)
