extends Node
class_name FoodSpawner

var food_scene : PackedScene = preload("res://scenes/food.tscn")

@export var limit_minimum : Vector2 = Vector2(200,200)
@export var limit_maximum : Vector2 = Vector2(500,500)
@export var maximum_concurrent_foods : int = 1


func _process(delta: float) -> void:
	if get_child_count() >= maximum_concurrent_foods:
		return
	spawn_food()


func spawn_food() -> void:
	var food : Food = food_scene.instantiate()
	food.global_position = randVect2()
	food.food_eaten.connect(_on_food_eaten)
	add_child(food)


func randVect2() -> Vector2:
	return Vector2(
		randi_range(limit_minimum.x,limit_maximum.x),
		randi_range(limit_minimum.y,limit_maximum.y)
	)


func _on_food_eaten(food : Node2D) -> void:
	food.queue_free()
