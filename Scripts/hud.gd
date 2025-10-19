extends Control
class_name HUD

@onready var time_label: Label = $TimeLabel
@onready var time_timer: Timer = $TimeLabel/TimeTimer
@onready var score_text: Label = $Score/ScoreText
@onready var input_display: TextureRect = $InputDisplay


const input_dir: Dictionary = {
	"move_up": preload("res://Sprites/MovementUp.png"),
	"move_down": preload("res://Sprites/MovementDown.png"),
	"move_left": preload("res://Sprites/MovementLeft.png"),
	"move_right": preload("res://Sprites/MovementRight.png")
}

var seconds: int = 0
var minutes: int = 0

func _process(delta):
	update_time_label()

func update_input_display(event):
	for key in input_dir:
		if event.is_action_pressed(key):
			# Set the texture equal to the image resource corresponding to the key in the dictionary
			input_display.texture = input_dir[key]

func update_score(score : int):
	score_text.text = "x" + str(score)

func hide_display():
	input_display.hide()

func update_time_label():
	# String formatting for the time label
	# Check out the docs for more info:
	# https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_format_string.html
	var temp_seconds: String = "%0*d" % [2, seconds]
	var temp_minutes: String = "%0*d" % [2, minutes] 
	time_label.text = "TIME: " + temp_minutes + ":" + temp_seconds

func get_and_stop_time_text() -> String:
	time_timer.stop()
	return time_label.text

func _on_time_timer_timeout():
	seconds += 1
	if seconds >= 60:
		seconds = 0
		minutes += 1
