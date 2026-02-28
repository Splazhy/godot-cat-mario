extends Node2D

@export var clear_color := Color("#A3B3FE")
@onready var player: Player = $Player

func _ready() -> void:
	RenderingServer.set_default_clear_color(clear_color)
	player.died.connect(_on_player_died)


func _on_player_died() -> void:
	get_tree().paused = true
	await get_tree().create_timer(5.0).timeout
	get_tree().paused = false
	get_tree().reload_current_scene()
