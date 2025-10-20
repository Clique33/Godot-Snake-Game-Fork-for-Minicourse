extends CharacterBody2D
class_name Head

@export var speed : float:
	set(value):
		speed = value
		_internal_speed = speed*1000

var possible_directions : Array[Vector2] = [Vector2.DOWN,Vector2.UP,Vector2.RIGHT,Vector2.LEFT]
var direction_of_movement : Vector2

var _internal_speed : float

@onready var moved_audio_player: AudioStreamPlayer2D = $MovedAudioPlayer

func _process(delta: float) -> void:
	velocity = direction_of_movement*_internal_speed*delta
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	var vector : Vector2 = Input.get_vector(
			"move_left",
			"move_right",
			"move_up",
			"move_down",
	)
	if vector in possible_directions and vector != -direction_of_movement:
		direction_of_movement = vector
		rotation = direction_of_movement.angle()
		moved_audio_player.play()
