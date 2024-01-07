extends CharacterBody3D

@export var speed : float = 10
@export var jump_height : float = 13
@export var gravity : float = 27.3

# Declare a variable to hold the camera reference
var camera

func _enter_tree(): # This finds the camera so that we can use it to determine which way is "forward" during movement
	camera = get_node("/root/Node3D/Camera3D") # Please make sure the camera in any scene is the child of only the root

func _physics_process(delta):
	var direction = Vector3()

	# Check for input actions and update direction vector
	if Input.is_action_pressed('move_forward'):
		direction.z -= 1
	if Input.is_action_pressed('move_back'):
		direction.z += 1
	if Input.is_action_pressed('move_left'):
		direction.x -= 1
	if Input.is_action_pressed('move_right'):
		direction.x += 1

	# Normalize the direction vector
	if direction.length() > 0: # If you're trying to move
		direction = direction.normalized()

		direction = direction.rotated(Vector3.UP, camera.rotation.y) # Rotates your direction based on where the camera is facing
		direction = direction.rotated(Vector3.RIGHT, camera.rotation.x) # see above

		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else: # If you're not moving, stop moving
		velocity.x = 0
		velocity.z = 0

	velocity.y -= gravity * delta # You fall at the speed of gravity, and you accelerate over time

	if is_on_floor() and Input.is_action_just_pressed('jump'): # You only jump if you're on the ground and press the jump button
		velocity.y = jump_height

	move_and_slide() # This is the kind of movement we're doing, since we have physics and such
