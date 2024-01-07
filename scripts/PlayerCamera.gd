extends Camera3D

var player # References the player within this script
var offset = Vector3(0, 5, -10) # These values are XYZ coordinates saying how far away the camera should be from the player
var mouse_sensitivity = 0.005 # Should be self explanitory
var horizontal_angle = 0 # Stores the camera's current rotation. 0 by default.
var vertical_angle = 0 # See above

var is_mouse_captured = true # Public variable to keep the mouse trapped inside the game. Turn this off inside of menus.
var invert_y_axis = false # Public variable to say whether you're playing with inverted controls or not. Should be moved to a config file.

func _ready():
	player = get_parent().get_node("Player") # This code only works if the camera and player are siblings. Please keep in mind if you plan on changing heirarchy.

func _input(event): # Godot doesn't have mouse inputs as a standardized input method, so this code is necessary to make it read mouse movements
	if event is InputEventMouseMotion:
		horizontal_angle -= event.relative.y * mouse_sensitivity
		vertical_angle -= event.relative.x * mouse_sensitivity
		horizontal_angle = clamp(horizontal_angle, -PI / 2, PI / 3) # This prevents the camera from wrapping around the characture vertically (up/down), so continuing to scroll up locks it as direcly above the player

func _process(delta): # This will make an error in the debugger for going unused, as it does literally nothing unless something goes wrong
	if player == null: # Debug checker to make sure it's actually finding a player to follow. If it doesn't, it should print the line below in the console.
		print("Player node not found.")
		return

	if is_mouse_captured: # This code actually handles the mouse capturing, based on the true/false state of the is_mouse_captured variable
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	var basis = Basis(Vector3(0, 1, 0), vertical_angle) * Basis(Vector3(1, 0, 0), horizontal_angle).orthonormalized() # creates a variable "basis" from the camera's angle, used for calculations below

	var camera_position = player.global_transform.origin + basis * offset # This code uses the player position to place the camera, forcing it to remain the distance defined by Offset.

	global_transform.origin = camera_position # Sets the camera's transformation origin to its current position

	look_at(player.global_transform.origin, Vector3.UP) # Forces the camera to look at the player

# Future gamepad code, may or may not work.
# var gamepad_input = Vector2(Input.get_joy_axis(0, JOY_AXIS_2), Input.get_joy_axis(0, JOY_AXIS_3))
# horizontal_angle -= gamepad_input.x * gamepad_sensitivity
# vertical_angle -= gamepad_input.y * gamepad_sensitivity
