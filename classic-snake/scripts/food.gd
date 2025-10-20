extends Node2D

signal food_eaten(food)


func _on_food_hitbox_body_entered(body: Node2D) -> void:
	#print(body," entrou")
	food_eaten.emit(self)
	#emit_signal("food_eaten")
