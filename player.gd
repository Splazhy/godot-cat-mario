class_name Player
extends CharacterBody2D

@export var tile_size := 32
## Tile per second
@export var speed := 5.0
## Height in tiles
@export var jump_height := 4.5

@onready var gravity := ProjectSettings.get_setting("physics/2d/default_gravity") as float
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var hurtbox: Area2D = $HurtArea

signal died

var jump_init_velocity: float:
	get():
		return sqrt(2 * jump_height * tile_size * gravity)


func _ready() -> void:
	animation.play("default")
	hurtbox.body_entered.connect(func(_body): die())
	hurtbox.area_entered.connect(func(_area): die())


func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta

	if Input.is_action_pressed("run_right"):
		velocity.x = speed * tile_size
		animation.flip_h = false
	elif Input.is_action_pressed("run_left"):
		velocity.x = -speed * tile_size
		animation.flip_h = true
	else:
		velocity.x = 0.0

	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = -jump_init_velocity

	if is_on_floor():
		if velocity.x == 0.0:
			animation.play("default")
		else:
			animation.play("run")
	else:
		if velocity.y < 0.0:
			animation.play("jump")
		else:
			animation.play("default")

	move_and_slide()

func die() -> void:
	animation.play("die")
	# Disable physics process to play the die animation without getting overridden.
	set_physics_process(false)
	died.emit()