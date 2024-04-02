extends "res://addons/gdquest_practice_framework/tester/test.gd"

var candy_scene_practice: String = _load("candy.tscn", true).instantiate().scene_file_path
var candy_scene_solution: String = _load("candy.tscn", false).instantiate().scene_file_path

var practice_balloon: Area2D = null
var solution_balloon: Area2D = null


func _setup_state() -> void:
	var practice_balloons := _practice.find_children("", "Area2D")
	var solution_balloons := _solution.find_children("", "Area2D")
	practice_balloon = practice_balloons.front()
	solution_balloon = solution_balloons.front()

	await get_tree().create_timer(1.0).timeout
	var left_click_event := InputEventMouseButton.new()
	left_click_event.button_index = MOUSE_BUTTON_LEFT
	left_click_event.pressed = true
	for balloon in practice_balloons + solution_balloons:
		seed(0)
		balloon._input_event(get_viewport(), left_click_event, 0)


func _build_checks() -> void:
	_add_simple_check(
		tr("When clicked, the balloon spawns 3 candies."),
		func() -> String:
			var hint := tr("Did you loop thee times and add the candy under the proper node?")
			var candies: Array = practice_balloon.get_children().filter(is_candy_predicate.bind(candy_scene_practice))
			return "" if candies.size() == 3 else hint
	)

	_add_simple_check(
		tr("The candies are spawned at random positions around the balloon, within a 100 pixels radius."),
		func() -> String:
			var practice_candies := practice_balloon.get_children().filter(is_candy_predicate.bind(candy_scene_practice))
			var solution_candies := solution_balloon.get_children().filter(is_candy_predicate.bind(candy_scene_solution))

			var is_position_same: Array[bool] = []
			for idx in range(practice_candies.size()):
				is_position_same.push_back(practice_candies[idx].position == solution_candies[idx].position)

			var identity_predicate := func(x: bool) -> bool: return x
			var hint := tr("Did you propery calculate the candy position?")
			return "" if is_position_same.all(identity_predicate) else hint
	)
	checks.back().dependencies.append(checks.front())

func is_candy_predicate(node: Node, gdscript_path: String) -> bool:
	return node.scene_file_path == gdscript_path
