### Author: Claire O'Farrell
# DIALOGUE CONTROLLER

extends Control

signal init_dialogue

signal control_dialogue_complete

signal widget_dialogue_control_signal

#### GUIDE TO DIALOGUE ####
# This guide will help you implement dialogue for any NPCs in your level.
# All NPCs will use this node, the dialogueControl node, to send dialogue from
# NPCs to the dialogueBox node.  The dialogueBox node functions like a printer here
# and displays the dialogue you send to it.

### HOW TO IMPLEMENT ###
# STEP 1: Give your NPC an area2D, ex. NPCDialogueArea with a CollisionShape2D attatched.  This
# will indicate if your NPC is 'in range' to be interacted with.  Set up the collision shape as normal

# STEP 2: Give your NPC a script, ex. NPCDialogue.  This file will be checking if the npc is in range
# using the collision shapes and it will also hold and send your dialogue data to the dialogueControl.

# STEP 3: Seting up the script.  Set up the script so that it stores your dialogue and
# checks if you're within interaction range.  See the Widget scene's widgetDialogue script for more
# detail.

# STEP 4: Connect dialogueControl's init dialogue to your NPC.  If your NPC is within range
# of the player this signal will tell that npc to load their dialogue.

# STEP 5: Follow the code in the widgetDialogue to send your dialogue to the dialogueBox.
# If you want your NPC to say multiple things you will want to include the dialogue_counter
# in your script, this will allow you to load multiple dialogues.

# STEP 7: Follow the code in dialogueBox & dialougeControl
# to finish connecting your dialogue to the dialogueDisplay.

# STEP 6: (if you're doing multiple dialogues) Connect dialogueBox's completed signal to your 
# dialogue script via dialogueControl, this will signal to increment the dialogue_counter and 
# tells the script to load that next.

# This system can be modified to include dialogue based on toggles, inventory, status, etc. etc.
# You should be able to do that within the NPC's dialogue script but you'll have to include some
# extra code.

### Please ask Claire O'Farrell (discord claireo.) if you have any questions! ###

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("init_dialogue")


func _on_Widget_widget_dialogue_signal(dialogue):
	emit_signal("widget_dialogue_control_signal", dialogue)


func _on_dialogueBox_dialogue_complete():
	emit_signal("control_dialogue_complete")
