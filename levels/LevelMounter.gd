extends Node2D

@export var levelPaths : Array[PackedScene];
var currentLevelIndex : int = 0;
var currentLevel : Node2D;

func _ready():
	loadLevel();

func nextLevel():
	currentLevel.queue_free();
	currentLevelIndex += 1;
	loadLevel();

func goToLevelIndex(index):
	currentLevel.queue_free();
	currentLevelIndex = index;
	loadLevel();

func loadLevel():
	var level = levelPaths[currentLevelIndex].instantiate();
	add_child(level);
	currentLevel = level;
