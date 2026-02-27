class_name Player
extends CharacterBody2D

@export var tile_size := 32
## Tile per second
@export var speed := 5.0
## Height in tiles
@export var jump_height := 4.5

@onready var gravity := ProjectSettings.get_setting("physics/2d/default_gravity") as float

var jump_init_velocity: float:
	get():
		return sqrt(2 * jump_height * tile_size * gravity)

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta

	if Input.is_action_pressed("ui_right"):
		velocity.x = speed * tile_size
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed * tile_size
	else:
		velocity.x = 0.0

	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = -jump_init_velocity

	move_and_slide()
