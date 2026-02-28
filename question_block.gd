extends StaticBody2D

@onready var activate_area: Area2D = $ActivateArea
@onready var animation: AnimationPlayer = $AnimationPlayer

var _activated := false

func _ready() -> void:
	activate_area.body_entered.connect(_on_activate)
	activate_area.area_entered.connect(_on_activate)


func _on_activate(_node) -> void:
	if _activated:
		return
	_activated = true
	animation.play("bounce")
