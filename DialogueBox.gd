### Author: Claire O'Farrell
# DIALOGUE BOX

extends Control

var dialogue_index = -1;
var finished = false;
signal dialogue_complete

func _ready():
	hide()
	
func _process(delta):
	$"nextIndicator".visible = finished

func load_dialogue(dialogue):
	dialogue_index += 1
	if dialogue_index < dialogue.size():
		finished = false
		$dialogueText.bbcode_text = dialogue[dialogue_index]
		$dialogueText.percent_visible = 0
		$dialogueTween.interpolate_property(
			$dialogueText, "percent_visible", 0, 1, 1, 
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		
		$dialogueTween.start()
	else:
		dialogue_index = -1;
		finished = true
		hide()
		emit_signal("dialogue_complete")


func _on_Tween_tween_completed(object, key):
	finished = true

# Get's Widget's dialogue, then load's the dialogue accordingly.
func _on_dialogueControl_widget_dialogue_control_signal(widget_dialogue):
	show()
	load_dialogue(widget_dialogue)
