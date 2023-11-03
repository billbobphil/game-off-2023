extends CharacterBody2D


@export var speed : float = 300.0
@export var jumpVelocity : float = -500.0
@export var fallMultiplier : float = 2.5
var jumpTimer : float = 0;
var isJumping : bool = false;
@export var jumpCutoffSpeed : float = 100.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#TODO: coyote time
#TODO: buffering?
#TODO: double-jump?
#TODO: wall-jump?
#TODO: dash?
#TODO: scale-effects

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta * (fallMultiplier - 1)

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jumpVelocity
		isJumping = true

	if isJumping and !Input.is_action_pressed("jump"):
		if(velocity.y < jumpCutoffSpeed):
			velocity.y = jumpCutoffSpeed
		isJumping = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
