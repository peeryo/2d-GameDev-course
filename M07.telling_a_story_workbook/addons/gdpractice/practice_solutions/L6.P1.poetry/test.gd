extends "res://addons/gdpractice/tester/test.gd"

func _build_requirements() -> void:
	_add_callable_requirement(
		"There should be an 'lines' String",
		func() -> String: 
			if not "lines" in _practice or (not _practice.lines is String) or (_practice.lines as String).length() != _solution.lines.length():
				return tr("There is no 'lines' String. Did you remove it? It's required for the practice to work")
			return ""
	)
	_add_callable_requirement(
		"There should be an 'appearance_time' float",
		func() -> String: 
			if not "appearance_time" in _practice or not (_practice.appearance_time is float):
				return tr("There is no 'appearance_time' number. Did you remove it? It's required for the practice to work")
			return ""
	)

var _initial_visible_ratio := 0.0
var _final_received_visible_ratio := 0.0
var _final_expected_visible_ratio := 0.0

func _setup_populate_test_space() -> void:
	_initial_visible_ratio = (_practice.rich_text_label as RichTextLabel).visible_ratio
	var time_ratio := 10.0
	var duration: float = _practice.appearance_time / time_ratio
	await get_tree().create_timer(duration).timeout
	_final_received_visible_ratio = (_practice.rich_text_label as RichTextLabel).visible_ratio * time_ratio
	_final_expected_visible_ratio = (_solution.rich_text_label as RichTextLabel).visible_ratio * time_ratio

func _build_checks() -> void:
	var visible_ratio_is_set_to_zero := Check.new()
	visible_ratio_is_set_to_zero.description = tr("The text visible ratio is set to zero")
	
	visible_ratio_is_set_to_zero.checker = func() -> String:
		if not is_zero_approx(_initial_visible_ratio):
			return "The rich text label's visibility ratio is not set to zero before tweening. We expected '0.0', we got '%s'"%[_practice.rich_text_label.visible_ratio]
		return ""
	
	var visible_ratio_is_tweened := Check.new()
	visible_ratio_is_tweened.description = tr("The text visible ratio is tweened to 1")
	
	visible_ratio_is_tweened.checker = func() -> String:
		var tweens := get_tree().get_processed_tweens()
		var valid_tweens: Array[Tween] = []
		for tween in tweens:
			var bound_node_name := str(tween).split("(bound to ")[1].rstrip(")")
			if bound_node_name == _solution.name:
				valid_tweens.append(tween)
		if valid_tweens.size() < 2:
			return "There are no tweens running in the scene, or the tween isn't tweening anything? Did you create a tween and made it tween a property?"
		if not is_equal_approx(_final_received_visible_ratio, _final_expected_visible_ratio):
			return "It doesn't look like the visible ratio is tweened to its final value over appearance_time seconds. Did you tween it to 1.0? And did you set its duration to the appearance_time value?"
		return ""
	
	checks = [visible_ratio_is_set_to_zero, visible_ratio_is_tweened]
	
	
