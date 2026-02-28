extends Node2D

@export var clear_color := Color("#A3B3FE")

@onready var player: Player = %Player
@onready var life_screen_scene := load("res://life_screen.tscn")

func _ready() -> void:
	RenderingServer.set_default_clear_color(clear_color)
	player.died.connect(_on_player_died, ConnectFlags.CONNECT_DEFERRED)


func _on_player_died() -> void:
	GameManager.life -= 1
	await get_tree().create_timer(3.0).timeout
	var life_screen = life_screen_scene.instantiate()
	add_sibling(life_screen)
	await get_tree().create_timer(2.0).timeout
	get_tree().reload_current_scene()
	life_screen.queue_free()
