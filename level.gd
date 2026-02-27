extends Node2D

@export var clear_color := Color("#A3B3FE")

func _ready() -> void:
	RenderingServer.set_default_clear_color(clear_color)