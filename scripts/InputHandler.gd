extends Node

# Reference to the GameManager
var game_manager

func _ready():
	# Assuming the GameManager node is a parent of the InputHandler node
	game_manager = get_parent()

func _input(event):
	if event is InputEventKey and event.is_pressed() and Input.is_action_just_pressed("ui_cancel"):
		game_manager.set_pause_status(!get_tree().paused)
