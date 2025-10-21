extends CharacterBody2D
class_name Head

signal head_moved

@export var direction_of_movement : Vector2
@export var speed : float:
	set(value):
		speed = value
		_internal_speed = speed*80
@export var offset_vector : Vector2 = Vector2(16,16)
@export var grid_size : Vector2 = Vector2(32,32)

var possible_directions : Array[Vector2] = [Vector2.DOWN,Vector2.UP,Vector2.RIGHT,Vector2.LEFT]
var direction_of_next_movement : Vector2
var _internal_speed : float

@onready var moved_audio_player: AudioStreamPlayer2D = $MovedAudioPlayer

func _ready() -> void:
	direction_of_next_movement = direction_of_movement

func _process(delta: float) -> void:
	change_direction_snapped()
	move(delta)


func _unhandled_input(event: InputEvent) -> void:
	var vector : Vector2 = Input.get_vector(
			"move_left",
			"move_right",
			"move_up",
			"move_down",
	)
	if vector in possible_directions and vector != -direction_of_movement and vector != direction_of_movement:
		direction_of_next_movement = vector
		moved_audio_player.play()


func move(delta : float) -> void:
	velocity = direction_of_movement*_internal_speed*delta
	position = snapped(position + velocity,Vector2(4,4))


func change_direction_snapped() -> void:
	if position+offset_vector == snapped(position,grid_size):
		head_moved.emit()
		direction_of_movement = direction_of_next_movement
		rotation = direction_of_movement.angle()
