extends Node2D
#remember to hold CMD on a Mac to auto write onready vars
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var wait_timer: Timer = $WaitTimer
@onready var shadow: Sprite2D = $Shadow


func _ready() -> void:
	#alternate between waiting and hopping
	wait_timer.wait_time = randf_range(1.0, 3.0)
	wait_timer.one_shot = true
	wait_timer.timeout.connect(_animate_one_hop)
	wait_timer.start()
	
func _animate_one_hop() -> void:
	#allows us to calculate direction during hop
	const HOP_DURATION := 0.25
	const HALF_HOP_DURATION := HOP_DURATION / 2.0
	
	#makes hop go in random direction and land on random spot
	var random_direction := Vector2(1.0, 0.0).rotated(randf() * 2.0 * PI)
	var land_position := random_direction * randf_range(0.0, 30.0)
	
	#make the tween and set it to hop and animate multiple at same time
	var tween := create_tween().set_parallel()
	tween.tween_property(sprite_2d, "position:x", land_position.x, HOP_DURATION)
	
	#why just position not position:x?
	tween.tween_property(shadow, "position", land_position, HOP_DURATION)
	
	#create animation to make it jump up and down
	tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_OUT)
	const JUMP_HEIGHT := 16.0
	tween.tween_property(sprite_2d, "position:y", land_position.y - JUMP_HEIGHT, HALF_HOP_DURATION)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(sprite_2d, "position:y", land_position.y, HALF_HOP_DURATION)
	
	#we can make the timer duration randomly fire between 1-3 seconds
	wait_timer.wait_time = randf_range(1.0, 3.0)
	
	#connect a tweens finished signal to timer's start so it keeps firing
	#animation ends, wait time, then it starts again
	tween.finished.connect(wait_timer.start)
