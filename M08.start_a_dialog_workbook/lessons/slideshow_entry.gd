#extends Resource it wasn't clear you delete extends once you add class_name
class_name SlideShowEntry extends Resource

@export var expression := preload("res://assets/emotion_happy.png")
@export var character := preload("res://assets/sophia.png")
@export_multiline var text := "" 
