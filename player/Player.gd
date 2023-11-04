extends CharacterBody2D

class_name Player

@export var speed : float = 300.0
@export var jumpVelocity : float = -500.0
@export var fallMultiplier : float = 2.5
var jumpTimer : float = 0;
var isJumping : bool = false;
@export var jumpCutoffSpeed : float = 100.0
var coyoteTimer : float = 0;
@export var coyoteTimeWindow : float = 0;
var shouldFall : bool = false;
var inputBufferTimer : float = 0;
var isInputBuffered : bool = false;
@export var inputBufferTimeWindow : float = 0;

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#TODO: double-jump?
#TODO: wall-jump?
#TODO: dash?
#TODO: scale-effects

func _physics_process(delta):

	handleInputBufferTimer(delta);

	if(is_on_floor()):
		onContactWithFloorHandler()

	coyoteTimeHandler(delta);

	if shouldFall:
		velocity.y += gravity * delta * (fallMultiplier - 1)

	jumpInputHandler();
	horizontalMovement();
	move_and_slide()

func jump():
	velocity.y = jumpVelocity
	isJumping = true

func bufferredJump():
	jump();
	isInputBuffered = false;
	inputBufferTimer = 0;

func horizontalMovement():
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

func handleInputBufferTimer(delta):
	if isInputBuffered:
		inputBufferTimer += delta;
		if(inputBufferTimer > inputBufferTimeWindow):
			isInputBuffered = false;
			inputBufferTimer = 0;

func onContactWithFloorHandler():
	coyoteTimer = 0;
	shouldFall = false;
	isJumping = false;
	if(isInputBuffered):
		bufferredJump();

func coyoteTimeHandler(delta):
	#leave an edge if you are not on the floor anymore and you are not jumping
	if !is_on_floor() and !isJumping:
		coyoteTimer += delta;
	elif isJumping:
		shouldFall = true;

	if(coyoteTimer > coyoteTimeWindow):
		shouldFall = true;

func isCoyoteTimeValid():
	return coyoteTimer < coyoteTimeWindow;

func jumpInputHandler():
	if !isJumping && Input.is_action_just_pressed("jump") && (is_on_floor() || isCoyoteTimeValid()):
		jump();

	if isJumping and !Input.is_action_pressed("jump"):
		if(velocity.y < jumpCutoffSpeed):
			velocity.y = jumpCutoffSpeed

	if Input.is_action_just_pressed("jump") && !is_on_floor():
		isInputBuffered = true;