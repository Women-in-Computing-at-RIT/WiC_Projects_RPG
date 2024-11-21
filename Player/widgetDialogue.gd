### Author: Claire O'Farrell
# EXAMPLE FOR DIALOGUE SYSTEM

extends KinematicBody2D

var inRange = false


# Dialogue is stored in arrays.  
# Each array is a seperate set of dialogue and each item is the dialouge 
# that will show up in the box
var widget_dialogue_1 = ["Hello widget WiC!",
"I hope this widget works!",
"This is some widget text"]


# This set of dialogue will be shown the next time the player interacts
# with Widget
var widget_dialogue_2 = ["This is some additional text",
"It's display the second time you talk to me!"]

# Used to keep track of what set of dialogue the Widget is on.
var dialogue_counter = 0;

# Used to signal the dialogueBox to print Widget's dialogue
signal widget_dialogue_signal(dialogue)

# Checks if the area2D that just entered our collison box
# is the player.  If so, Widget is in range for an interaction.
func _on_widgetDialogue_area_entered(area):
	inRange = area.get_name() == "playerDialogueBox"
	

# Checks if the area2D that just exited our collison box
# was the player.  If so, Widget is out of range for an interaction.
func _on_widgetDialogue_area_exited(area):
	inRange = !(area.get_name() == "playerDialogueBox")
	

# Checks if we are in range of the player and what dialogue set we are on.
# Then send the appropriate dialogue to the dialogueBox.  You can do this
# by passing the variable through the signal as a parameter.
func _on_dialogueControl_init_dialogue():
	if(inRange):
		if(dialogue_counter == 0):
			emit_signal("widget_dialogue_signal", widget_dialogue_1)
		else:
			emit_signal("widget_dialogue_signal", widget_dialogue_2)

# When the dialogueBox has completed our current dialogue set,
# increment the dialogue counter.
# NOTE: this is not needed if you do not have multiple sets of dialogue.

func _on_dialogueControl_control_dialogue_complete():
	if(inRange):
		dialogue_counter += 1;
