extends Node2D

@export var levelName : String;
@onready var levelNameLabel : Label = get_node("CanvasLayer/LevelName");
@onready var canvas : CanvasLayer = get_node("CanvasLayer");
var isEnabled : bool = false;
var hasEverBeenEnabled : bool = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	# canvas.visible = true;
	# levelNameLabel.text = levelName;
	# await get_tree().create_timer(.5).timeout;
	# get_tree().paused = true;
	pass;

func _process(_delta):
	if(!hasEverBeenEnabled):
		hasEverBeenEnabled = true;
		canvas.visible = true;
		levelNameLabel.text = levelName;
		isEnabled = true;
		get_tree().paused = true;

	if(isEnabled):
		if(Input.is_action_just_pressed("jump") || Input.is_action_just_pressed("acknowledge_dialog")):
			beginLevel();

func beginLevel():
	get_tree().paused = false;
	SoundManager.playAbilityUnlock();
	queue_free();