extends CharacterBody2D

class_name Player

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var collisionShape : CollisionShape2D = $CollisionShape2D

@export_group("")
var mass : float = 1.0;

@export_group("Ability Flags")
@export var isDashEnabled : bool = false;
@export var isScaleUpEnabled : bool = false;
@export var isScaleDownEnabled : bool = false;

@export_group("Scale Properties")
@export_subgroup("Normal Scale")
@export var normalSpriteScale : float = 1.0
@export var normalMass : float = 1.0;
@export var normalSpriteFrames : SpriteFrames;
@export var normalSpeed : float = 300.0;
@export_subgroup("Small Scale")
@export var smallSpriteScale : float = 0.5
@export var smallMass : float = 0.5;
@export var smallSpriteFrames : SpriteFrames;
@export var smallSpeed : float = 100.0;
@export_subgroup("Large Scale")
@export var largeSpriteScale : float = 2.0
@export var largeMass : float = 2.0;
@export var largeSpriteFrames : SpriteFrames;
@export var largeSpeed : float = 300.0;

@export_group("Movement Properties")
var speed : float = 300.0
@export_subgroup("Jump Properties")
@export var jumpVelocity : float = -700.0
@export var fallMultiplier : float = 4
@export var jumpCutoffSpeed : float = -300
@export var coyoteTimeWindow : float = 0.1;
@export var inputBufferTimeWindow : float = 0.1;
var jumpTimer : float = 0;
var isJumping : bool = false;
var coyoteTimer : float = 0;
var shouldFall : bool = false;
var inputBufferTimer : float = 0;
var isInputBuffered : bool = false;
@export_subgroup("Dash Properties")
@export var dashSpeed : float = 600.0;
@export var dashDuration : float = 0.2;
@export var dashCooldown : float = 0.5;
var isDashing : bool = false;
var canDash : bool = true;
var dashTimer : float = 0;
var dashCooldownTimer : float = 0;



var currentScale : Scales = Scales.NORMAL;

enum Scales {
	SMALL,
	NORMAL,
	LARGE
}

var scaleDictionary : Dictionary = {};

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#TODO: double-jump?
#TODO: wall-jump?
#TODO: scale-effects

func _ready():
	initializeScaleDictionary();
	sprite.animation = "idle";
	sprite.play();

	for deathPlane in get_tree().get_nodes_in_group("deathPlanes"):
		deathPlane.kill_player.connect(die);

func initializeScaleDictionary():
	var normalScale : Scale = Scale.new();
	normalScale.spriteScale = normalSpriteScale;
	normalScale.mass = normalMass;
	normalScale.spriteFrames = normalSpriteFrames;
	normalScale.moveSpeed = normalSpeed;
	scaleDictionary[Scales.NORMAL] = normalScale;

	var smallScale : Scale = Scale.new();
	smallScale.spriteScale = smallSpriteScale;
	smallScale.mass = smallMass;
	smallScale.spriteFrames = smallSpriteFrames;
	smallScale.moveSpeed = smallSpeed;
	scaleDictionary[Scales.SMALL] = smallScale;

	var largeScale : Scale = Scale.new();
	largeScale.spriteScale = largeSpriteScale;
	largeScale.mass = largeMass;
	largeScale.spriteFrames = largeSpriteFrames;
	largeScale.moveSpeed = largeSpeed;
	scaleDictionary[Scales.LARGE] = largeScale;

func _process(_delta):
	if(isScaleUpEnabled && Input.is_action_just_pressed("scale_up")):
		scaleUp();

	if(isScaleDownEnabled && Input.is_action_just_pressed("scale_down")):
		scaleDown();

func scaleUp():
	if(currentScale == Scales.LARGE):
		return;
	elif(currentScale == Scales.SMALL):
		currentScale = Scales.NORMAL;
	else:
		currentScale = Scales.LARGE;
	applyScaleTransformations();

func scaleDown():
	if(currentScale == Scales.SMALL):
		return;
	elif(currentScale == Scales.LARGE):
		currentScale = Scales.NORMAL;
	else:
		currentScale = Scales.SMALL;
	applyScaleTransformations();
	
func applyScaleTransformations():
	var newScale : Scale = scaleDictionary[currentScale];
	sprite.sprite_frames = newScale.spriteFrames;
	collisionShape.scale.x = newScale.spriteScale;
	collisionShape.scale.y = newScale.spriteScale;
	mass = newScale.mass;
	speed = newScale.moveSpeed;
	sprite.animation = "idle";
	sprite.play();

func _physics_process(delta):

	if(velocity.x > 0):
		sprite.flip_h = false;
	elif(velocity.x < 0):
		sprite.flip_h = true;

	if(velocity.x != 0):
		if(sprite.animation != "run"):
			sprite.animation = "run";
			sprite.play();
	else:
		if(sprite.animation != "idle"):
			sprite.animation = "idle";
			sprite.play();

	handleInputBufferTimer(delta);
	handleDashTimer(delta);

	if(is_on_floor()):
		onContactWithFloorHandler()

	coyoteTimeHandler(delta);

	if shouldFall:
		velocity.y += gravity * delta * (fallMultiplier - 1) * mass

	jumpInputHandler();
	horizontalMovement();
	dashInputHandler();
	move_and_slide()

func jump():
	velocity.y = jumpVelocity
	isJumping = true

func bufferredJump():
	jump();
	isInputBuffered = false;
	inputBufferTimer = 0;

func horizontalMovement():
	if(isDashing):
		return;

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

func handleDashTimer(delta):
	if isDashing:
		dashTimer += delta
		if dashTimer > dashDuration:
			endDash()

	dashCooldownTimer += delta

func onContactWithFloorHandler():
	coyoteTimer = 0;
	shouldFall = false;
	isJumping = false;
	canDash = true;
	if(isInputBuffered):
		bufferredJump();

func coyoteTimeHandler(delta):
	#leave an edge if you are not on the floor anymore and you are not jumping
	if !is_on_floor() && !isJumping:
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

	if isJumping && !isDashing && !Input.is_action_pressed("jump"):
		if(velocity.y < jumpCutoffSpeed):
			velocity.y = jumpCutoffSpeed

	if Input.is_action_just_pressed("jump") && !is_on_floor():
		isInputBuffered = true;

func dashInputHandler():
	if(isDashEnabled && canDash && !isDashing && Input.is_action_just_pressed("dash")):
		beginDash();

func beginDash():
	isDashing = true;
	canDash = false;
	var dashDirection = getDashDirection();
	velocity = dashDirection * dashSpeed; #requires you to be already moving a direction
	dashTimer = 0.0;
	dashCooldownTimer = 0.0;
	shouldFall = true;

func endDash():
	isDashing = false
	velocity.x = 0;

func getDashDirection() -> Vector2:
	var direction = Vector2.ZERO;
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return direction.normalized()

func die(_body):
	print("player should die");
	self.queue_free()

