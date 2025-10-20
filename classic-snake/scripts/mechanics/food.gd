extends Node2D
class_name Food

signal food_eaten(food)


func _on_food_hitbox_body_entered(body: Node2D) -> void:
	food_eaten.emit(self)
