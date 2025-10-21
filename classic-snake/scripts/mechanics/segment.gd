extends Node2D
class_name Segment

signal head_hit

var is_hittable_by_head : bool = false


func _on_hitbox_area_body_entered(body: Node2D) -> void:
	if not (body is Head):# hit by other thing, but not the head
		return
	if not is_hittable_by_head:
		return
	head_hit.emit()


func _on_timer_timeout() -> void:
	if get_index() >= 3:# big enough to count
		is_hittable_by_head = true
