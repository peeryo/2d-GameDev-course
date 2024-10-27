extends Control
var expressions := {
	"happy": preload("res://assets/emotion_happy.png"),
	"regular": preload("res://assets/emotion_regular.png"),
	"sad": preload("res://assets/emotion_sad.png")
}

var bodies := {
	
	"sophia": preload("res://assets/sophia.png"),
	"pink": preload("res://assets/pink.png")
}

var dialog_items :Array[Dictionary] = [
	{
		"expression": expressions["regular"],
		"text": "Simple arrays are pretty easy",
		"character": bodies["pink"]
	},
	{
		"expression": expressions["sad"],
		"text": "They can get more complex and hard",
		"character": bodies["sophia"]
	},
	{
		"expression": expressions["happy"],
		"text": "I can tell them to only show strings",
		"character": bodies["pink"]
	},
	{
		"expression": expressions["regular"],
		"text": "What else can we do with them?",
		"character": bodies["sophia"]
	},
	{
		"expression": expressions["happy"],
		"text": "Well, perhaps we should use dictionaries instead",
		"character": bodies["pink"]
	},
	{
		"expression": expressions["regular"],
		"text": "Oh no, another new concept, I'm not sure I'm ready",
		"character": bodies["sophia"]
	},
]

var current_item_index := 0

@onready var rich_text_label: RichTextLabel = %RichTextLabel
@onready var next_button: Button = %NextButton
@onready var back_button = %BackButton
@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer
@onready var body: TextureRect = %Body
@onready var expression: TextureRect = %Expression

func _ready() -> void:
	show_text()
	next_button.pressed.connect(advance)
	#I imagine you need a signal like this to rewind
	back_button.pressed.connect(rewind)

## Draws the current text to the rich text element
func show_text() -> void:
	# We retrieve the current dictionary from the array and assign its
	# properties to the UI elements.
	var current_item := dialog_items[current_item_index]
	rich_text_label.text = current_item["text"]
	expression.texture = current_item["expression"]
	body.texture = current_item["character"]
	# We animate the text appearing letter by letter.
	rich_text_label.visible_ratio = 0.0
	var tween := create_tween()
	var text_appearing_duration: float = current_item["text"].length() / 30.0
	tween.tween_property(rich_text_label, "visible_ratio", 1.0, text_appearing_duration)

	# This is where we play the audio. We randomize the audio playback's start
	# time to make it sound different every time.
	var sound_max_length := audio_stream_player.stream.get_length() - text_appearing_duration
	var sound_start_position := randf() * sound_max_length
	audio_stream_player.play(sound_start_position)
	# We stop the audio when the text finishes appearing.
	tween.finished.connect(audio_stream_player.stop)
	slide_in()
	
func advance() -> void:
	current_item_index += 1
	if current_item_index >= dialog_items.size():
		current_item_index = 0
	else:
		show_text()
		
#Here's the rewind function, not sure what should happen at 0		
func rewind() -> void:
	current_item_index -= 1
	if current_item_index < 0:
		current_item_index = 0
	show_text()
	
func slide_in() -> void:
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_QUART)
	tween.set_ease(Tween.EASE_OUT)
	body.position.x = 200.0
	tween.tween_property(body, "position:x", 0.0, 0.3)
	body.modulate.a = 0.0
	tween.parallel().tween_property(body, "modulate:a", 1.0, 0.2)
	

	

	
