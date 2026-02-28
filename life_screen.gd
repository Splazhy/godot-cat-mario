extends Control

@onready var label: Label = %Label

func _ready() -> void:
	label.text = "x %d" % GameManager.life