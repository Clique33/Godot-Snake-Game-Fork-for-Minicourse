extends Node2D

func _on_food_food_eaten(food : Node2D) -> void:
	food.queue_free()
