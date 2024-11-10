## This resource represents a choice inside a dialogue item.
##
## DialogueChoice takes:
##
## [ul]A text
## A target dialogue line index to go to when picked
## Optionally, [member is_quit] can be set to [code]true[/code][/ul]
@icon("res://assets/dialogue_choice_icon.svg")
class_name DialogueChoice extends Resource
## The choice button text. Can only use plain text (no BBCode)
@export var text := ""
## The target item to jump to next. This is the index of the dialogue item the
## choice leads to. It is ignored if [member is_quit] is set to [code]true[/code].
@export_range(0, 20) var target_line_idx := 0
## If set to [code]true[/code], this choice quits the dialogue and the
## [code]target_line_idx[/code] is ignored.
@export var is_quit := false
