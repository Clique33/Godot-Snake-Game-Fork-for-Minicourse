extends Node2D
class_name Field

signal head_hit(head : Head)

func _on_border_area_body_entered(body: Node2D) -> void:
	if body is Head:
		head_hit.emit(body)
