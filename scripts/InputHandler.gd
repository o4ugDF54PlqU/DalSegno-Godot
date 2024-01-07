# This script is meant to handle the ability to pause and unpause, without itself getting paused. Without this script, the game would pause the pause screen.

extends Node

var game_manager # This line creates a variable to store the related GameManager

func _ready():
	# Assuming the GameManager node is a parent of the InputHandler node. Please update if you change the file structure.
	game_manager = get_parent()

func _input(event):
	if event is InputEventKey and event.is_pressed() and Input.is_action_just_pressed("ui_cancel"): #If you press the "ui_cancel" button, which is by default esc
		game_manager.set_pause_status(!get_tree().paused) # Find the current pause state in the GameManager script and change it
