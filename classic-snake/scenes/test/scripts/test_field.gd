extends Node2D

func _on_field_head_hit(head: Head) -> void:
	get_tree().reload_current_scene.call_deferred()
