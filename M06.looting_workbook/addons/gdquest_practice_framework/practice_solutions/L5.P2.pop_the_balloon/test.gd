extends "res://addons/gdquest_practice_framework/tester/test.gd"

var balloon_pop: Area2D = _load("balloon_pop.gd", true).new()

func _build_checks() -> void:
	_add_simple_check(
		tr("When the player clicks on the balloon, the balloon is freed."),
		func() -> String:
			var result := ""
			var left_click_event := InputEventMouseButton.new()
			left_click_event.button_index = MOUSE_BUTTON_LEFT
			left_click_event.pressed = true
			balloon_pop._input_event(get_viewport(), left_click_event, 0)
			var hint := tr("Did you forget to call the queue_free() function?")
			result = "" if balloon_pop.is_queued_for_deletion() else hint
			return result
	)
