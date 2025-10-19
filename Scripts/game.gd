extends Node2D
class_name Game

signal game_lost

@export_range(6.0, 18.0, 0.1) var player_speed: float = 12.0
@export_range(0, 10) var initial_segment_count: int = 3
var tw: Tween
var grid_size: int = 32
var score: int = 0:
	set(value):
		score = value
		if hud:
			hud.update_score(score)
var apple_spawner : PackedScene = preload("res://Scenes/apple.tscn")
var segment_spawner : PackedScene = preload("res://Scenes/segment.tscn")

@onready var snake = $Snake
@onready var head = $Snake/Head
@onready var hud: HUD = $UILayer/HUD
@onready var apples = $Apples
@onready var game_over: Control = $UILayer/GameOver
@onready var eat_audio_player: AudioStreamPlayer = $SoundEffects/EatAudioPlayer

func _ready():
	head.speed = player_speed
	create_apple()
	for i in initial_segment_count:
		create_segment()


func _unhandled_input(event):
	hud.update_input_display(event)
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()


func play_eaten_sound_effect() -> void:
	eat_audio_player.pitch_scale = randf_range(1.0, 1.4)
	eat_audio_player.play()


func create_apple():
	var apple = apple_spawner.instantiate()
	
	apple.connect("apple_eaten",_on_apple_eaten)
	apple.connect("respawn_apple_requested",create_apple)
	
	# Select a random position inside the play area
	apple.position.x = randi_range(64, 704)
	apple.position.y = randi_range(128, 704)
	
	# Snap the position based on the grid size
	# Note that the apple's Sprite2D and CollisionShape2D has been offset so that it looks correct
	apple.position.x = snapped(apple.position.x, grid_size)
	apple.position.y = snapped(apple.position.y, grid_size)
	
	# Add apple to scene
	apples.call_deferred("add_child", apple)


func create_segment():
	var segment = segment_spawner.instantiate()
	
	segment.connect("has_moved",_on_player_moved)
	segment.connect("segment_hit_by_head",_on_game_lost)
	# Move segment to last child
	segment.position = get_tail().position
	
	# Increment every segments' z-index by 1
	# This makes sure that the earliest segment is on top of the next one
	for selected_segment in snake.get_children():
		selected_segment.z_index += 1
	
	# Add segment to scene
	snake.call_deferred("add_child", segment)


func get_segment_positions():
	# Get position of all segments in the snake
	var snake_body: Array = snake.get_children()
	var segment_positions: Array
	for segment in snake_body:
		segment_positions.append(segment.position)
	return segment_positions


func get_tail():
	return snake.get_children().pop_back()


func _on_apple_eaten():
	score += 1
	play_eaten_sound_effect()
	create_segment()
	create_apple()


func _on_border_area_entered(area):
	if area is Head:
		game_lost.emit()


func _on_player_moved(speed: float):
	# First, check if the snake has at least one segment apart from the head
	if snake.get_child_count() > 1:
		tw = create_tween().set_parallel()
		var segment_positions = get_segment_positions()
		
		for segment_index in snake.get_child_count():
			var selected_segment = snake.get_child(segment_index)
			# Check if the segment is a not the head, basically
			if selected_segment is Segment:
				# The segment should tween to the position of the segment that is in front of it, and that's it!
				tw.tween_property(selected_segment, "position", segment_positions[segment_index-1], 1.0/speed)


func _on_game_lost():
	# Stop the player from moving and display the game over screen
	head.can_move = false
	hud.hide_display()
	head.turn.volume_db = -80
	game_over.make_screen_appear()	
	game_over.set_time_and_score(hud.get_and_stop_time_text(),score)
	
	# Make sure to stop the snake's tween movement (including the head's)
	if tw:
		tw.stop()
		head.tw.stop()
