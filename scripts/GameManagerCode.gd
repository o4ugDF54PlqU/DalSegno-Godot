# This code and scene are here to manage any information that we want to persist between levels and menus. Things like the ability to pause.
# This scene is autoloaded (which is set in the Project settings) which means it is always running
# You can access functions such as pausing in any other script bu using a line like the example below
# GameManager.toggle_pause()
# (GameManager being the name of this scene)

extends Node

# Potential game states, currently only PLAYING and PAUSED do anything
enum GameState {
	PLAYING,
	PAUSED,
	GAME_OVER
}

# Creates a variable to store the current GameState, is PLAYING by default
var game_state = GameState.PLAYING

# Called when the node enters the scene tree for the first time, currently unused.
func _ready():
	pass

func set_pause_status(is_paused): # Function that toggles mouse freedom based on the GameState
	game_state = GameState.PAUSED if is_paused else GameState.PLAYING
	get_tree().paused = game_state == GameState.PAUSED
	if is_paused: #If the game is paused, let the mouse move freely
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else: # If the game isn't paused, keep the mouse inside the game
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
