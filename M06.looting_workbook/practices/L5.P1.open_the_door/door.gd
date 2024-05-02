extends Area2D

@onready var animation_player: AnimationPlayer = $"AnimationPlayer"


func _input_event(viewport: Node, event: InputEvent, shape_index: int):
	# Complete this boolean expression to check if the input event is a left-mouse click.
	var event_is_mouse_click: bool = (
		#add this code to check if the left mouse button has been pressed 
		event is InputEventMouseButton and
		event.button_index == MOUSE_BUTTON_LEFT and 
		event.is_pressed()
	)

	if event_is_mouse_click:
		#after defining the open function, call it here
		open()

#add this function, open the DoorOpen scene, and set anim to open		
func open() -> void:
	animation_player.play("open")
	input_pickable = false
