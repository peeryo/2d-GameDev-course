extends Control

@onready var rich_text_label = %RichTextLabel
@onready var next_button = %NextButton

var dialog_items :Array[String] = [
	"Simple arrays are pretty easy",
	"They can get more complex and hard",
	"I can tell them to only show strings",
	"What else can we do with them?",
]

var current_item_index := 0

func show_text() -> void:
	var current_item := dialog_items[current_item_index]
	rich_text_label.text = current_item
	
func _ready() -> void:
	show_text()
	next_button.pressed.connect(advance)
	
func advance() -> void:
	current_item_index += 1
	if current_item_index == dialog_items.size():
		get_tree().quit()
	else:
		show_text()
	

	
