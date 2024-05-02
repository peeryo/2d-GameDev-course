extends Area2D


func _input_event(viewport: Node, event: InputEvent, shape_index: int):
	var event_is_mouse_release: bool = (
		event is InputEventMouseButton
		and event.button_index == MOUSE_BUTTON_LEFT
		#add the and and use released instead of clicked
		and event.is_released()
	)

	if event_is_mouse_release:
		#use queue free to pop the balloon
		queue_free()
