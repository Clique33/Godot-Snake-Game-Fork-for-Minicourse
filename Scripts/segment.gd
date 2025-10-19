extends Snake
class_name Segment

signal segment_hit_by_head

var is_active: bool = false

func _ready() -> void:
	make_segment_appear()

func make_segment_appear(speed: float = 1.0):
	# Play a tween when the segment first gets created and once the player has moved
	var tw: Tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)
	tw.tween_property(self, "scale", Vector2(1.0, 1.0), 1.0/speed).from(Vector2(0.0, 0.0))
	tw.connect("finished",turn_active)

func turn_active():
	is_active = true

func _on_area_entered(area):
	if area is Head and is_active:
		segment_hit_by_head.emit()
