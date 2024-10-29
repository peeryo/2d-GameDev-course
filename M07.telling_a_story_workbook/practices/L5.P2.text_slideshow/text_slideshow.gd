extends ColorRect

var items: Array[String] = [
	"Strings. Ints. Floats. Nulls.",
	"Long ago, the four types lived together in harmony.",
	"Then, everything changed when the typed Array arrived.",
	"Only the Programmer, student of all types, could stop them.",
	"But when the world needed them most, they were studying on GDQuest.",
]
var item_index := 0

@onready var rich_text_label: RichTextLabel = %RichTextLabel
@onready var button: Button = %Button


func _ready() -> void:
	show_text()
	button.pressed.connect(advance)

func show_text() -> void:
	# Make sure to display the text, done
	var current_item := items[item_index]
	rich_text_label.text = current_item

# Increments the index each time is called.
func advance() -> void:
	# make sure to increment the `item_index`, done
	item_index += 1
	if item_index >= items.size():
		item_index = 0
	# Don't forget to call the show_text function
	#else: why do we not need an else here? Clarification for students would be good
	show_text()
