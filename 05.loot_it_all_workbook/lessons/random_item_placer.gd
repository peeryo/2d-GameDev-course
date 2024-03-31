extends Node2D

func _ready() -> void:
	get_node("Timer").timeout.connect(_on_timer_timeout())


func _on_timer_timeout():
	pass # Replace with function body.
