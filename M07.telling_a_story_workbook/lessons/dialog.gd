extends Control

@onready var rich_text_label = %RichTextLabel
@onready var next_button = %NextButton
@onready var back_button = %BackButton

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
	#I imagine you need a signal like this to rewind
	back_button.pressed.connect(rewind)
	
func advance() -> void:
	current_item_index += 1
	if current_item_index >= dialog_items.size(): #== also works, but >= makes more sense to display last line
		#get_tree().quit()
		current_item_index = 0
	#else:
	show_text()
		
#Here's the rewind function, not sure what should happen at 0		
func rewind() -> void:
	current_item_index -= 1
	if current_item_index < 0:
		current_item_index = 0
	show_text()

	

	
