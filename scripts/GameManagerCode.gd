# This code and scene are here to manage any information that we want to persist between levels and menus. Things like the ability to pause.
# This scene is autoloaded (which is set in the Project settings) which means it is always running
# You can access functions such as pausing in any other script bu using a line like the example below
# GameManager.toggle_pause()
# (GameManager being the name of this scene)

extends Node

# Define your game states
enum GameState {
	PLAYING,
	PAUSED,
	GAME_OVER
}

# Current game state
var game_state = GameState.PLAYING

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Function to toggle pause
func set_pause_status(is_paused):
	game_state = GameState.PAUSED if is_paused else GameState.PLAYING
	get_tree().paused = game_state == GameState.PAUSED
	if is_paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
