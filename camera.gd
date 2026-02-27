extends Camera2D

@export var follow_target: Node2D
@export var camera_start: Marker2D
@export var camera_end: Marker2D

@onready var viewport_size := get_viewport_rect().size


func _process(_delta: float) -> void:
	if follow_target:
		if camera_start:
			position.x = max(follow_target.position.x, camera_start.position.x + viewport_size.x / 2)
		else:
			position.x = follow_target.position.x
		if camera_end:
			position.x = min(position.x, camera_end.position.x - viewport_size.x / 2)
		else:
			position.x = follow_target.position.x