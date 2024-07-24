extends ColorRect

var items: Array[String] = [
	"They prefer binary trees.",
	"There's no Wi-Fi signal in the forest.",
	"It has too many bugs!",
	"They can't Ctrl+S a sunset.",
	"Nature doesn't have a code review process.",
]
# change this to point at the correct item: "It has too many bugs!"
var item_index := 2
#When the index is incorrectly set to 0 why does one of the workbook pages display the correct answer?
#When I set it to the correct index of 2, both show the correct answer. 
#Why are there two? That's confusing

@onready var response_label: Label = %responseLabel


func _ready() -> void:
	show_text()


func show_text() -> void:
	response_label.text = items[item_index]
