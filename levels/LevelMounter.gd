extends Node2D

@export var levelPaths : Array[PackedScene];
@export var currentLevelIndex : int = 0;
var currentLevel : Node2D;

func _ready():
	loadLevel();

func nextLevel():
	currentLevel.queue_free();
	currentLevelIndex += 1;
	get_tree().paused = false;
	loadLevel();

func goToLevelIndex(index):
	currentLevel.queue_free();
	currentLevelIndex = index;
	loadLevel();

func loadLevel():
	var level = levelPaths[currentLevelIndex].instantiate();
	add_child(level);
	currentLevel = level;
	
	var canvasModulate = currentLevel.get_node("CanvasModulate");
	if canvasModulate:
		canvasModulate.visible = false
		await get_tree().create_timer(.1).timeout;
		canvasModulate.visible = true

