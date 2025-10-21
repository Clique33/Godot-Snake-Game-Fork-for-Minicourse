extends Node2D
class_name Snake

signal head_hit_body

@export var initial_number_of_segments : int 

var segment_spawner : PackedScene = preload("res://scenes/mechanics/segment.tscn")

@onready var head: Head = $Head
@onready var segments: Node2D = $Segments

func _ready() -> void:
	for i in initial_number_of_segments:
		add_segment()
	

func get_segments_positions():
	var result : Array[Vector2] = []
	for segment in segments.get_children():
		result.append(segment.position)
	return result


func add_segment() -> void:
	var new_segment : Segment = segment_spawner.instantiate()
	new_segment.position = head.position
	new_segment.head_hit.connect(_on_head_hit)
	segments.add_child.call_deferred(new_segment)

func _on_head_moved() -> void:
	if segments.get_child_count() == 0:
		return
	
	var segments_positions : Array[Vector2] = get_segments_positions()
	
	segments.get_child(0).position = head.position
	for i in range(1,len(segments_positions)):
		segments.get_child(i).position = segments_positions[i-1]


func _on_head_hit() -> void:
	head_hit_body.emit()
