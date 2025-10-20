extends CharacterBody2D

var possible_directions : Array[Vector2] = [Vector2.DOWN,Vector2.UP,Vector2.RIGHT,Vector2.LEFT]
var speed : float = 10000
var direction_of_movement : Vector2

func _process(delta: float) -> void:
	velocity = direction_of_movement*speed*delta
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
