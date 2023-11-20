extends Node2D

@onready var staticLayer = $StaticBody2D;
@onready var sprites = $Sprites;
var shouldCheckForPlayerSize = false;
var playerInContact = false;
var playerReference = null;

func _ready():
	for deathPlane in get_tree().get_nodes_in_group("deathPlanes"):
		deathPlane.kill_player.connect(reset);

func on_body_entered(body):
	if body.name == "Player":
		playerReference = body;
		playerInContact = true;
		shouldCheckForPlayerSize = true;

func on_body_exited(body):
	if body.name == "Player":
		playerInContact = false;
		shouldCheckForPlayerSize = false;

func _process(_delta):
	if(shouldCheckForPlayerSize && playerInContact):
		if(playerReference.currentScale == Player.Scales.LARGE):
			destroyPlatform()
			shouldCheckForPlayerSize = false;
			playerInContact = false;

func reset(_discard):
	restorePlatform();
	shouldCheckForPlayerSize = false;
	playerInContact = false;
	playerReference = null;

func destroyPlatform():
	staticLayer.collision_layer = 0;
	staticLayer.collision_mask = 0;
	sprites.visible = false;

func restorePlatform():
	staticLayer.collision_layer = 1;
	staticLayer.collision_mask = 1;
	sprites.visible = true;
