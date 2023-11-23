extends Node2D

@export var levelPaths : Array[PackedScene];
@export var currentLevelIndex : int = 0;
var currentLevel : Node2D;
@export var specialLevelIndexes : Array[int];

signal new_level_loaded

func _ready():
	loadLevel();

func _process(_delta):
	if(Input.is_action_just_pressed("restart")):
		if(!specialLevelIndexes.has(currentLevelIndex)):
			restartLevel();

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
	if(!specialLevelIndexes.has(currentLevelIndex)):
		enableHUD();
	else:
		disableHUD();

	var level = levelPaths[currentLevelIndex].instantiate();
	add_child(level);
	currentLevel = level;
	
	var canvasModulate = currentLevel.get_node("CanvasModulate");
	if canvasModulate:
		canvasModulate.visible = false
		await get_tree().create_timer(.1).timeout;
		canvasModulate.visible = true

	new_level_loaded.emit();

	var collectibleCount = currentLevel.get_node("Collectibles").get_child_count();
	var statTracker = currentLevel.get_node("Stats");
	print("Collectibles: " + str(collectibleCount));
	if(statTracker is StatsTracker):
		statTracker.setCollectiblesAvailable(collectibleCount);

func restartLevel():
	currentLevel.queue_free();
	loadLevel();

func enableHUD():
	var hudArray  = get_tree().get_nodes_in_group("HUD");
	if(hudArray.size() > 0):
		var hud = hudArray[0];
		hud.enableHUD();

func disableHUD():
	var hudArray  = get_tree().get_nodes_in_group("HUD");
	if(hudArray.size() > 0):
		var hud = hudArray[0];
		hud.disableHUD();
