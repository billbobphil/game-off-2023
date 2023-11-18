extends Node

class_name StatsTracker

signal death_count_changed
signal collectible_found_changed
signal collectible_available_changed

var deathCounter = 0;
@onready var timer : Timer = $Timer;
var isTimerStarted = false;
var elapsedTime : float = 0;
var collectiblesFound : int = 0;
var collectiblesAvailable : int = 0;

func _ready():
	for deathPlane in get_tree().get_nodes_in_group("deathPlanes"):
		deathPlane.kill_player.connect(incrementDeathCounter);
	
	for collectible in get_tree().get_nodes_in_group("collectibles"):
		collectible.collectible_found.connect(collectibleFound);
	
	timer.wait_time = 0.1;
	timer.timeout.connect(incrementElapsedTime);

func incrementDeathCounter(_body):
	deathCounter += 1;
	death_count_changed.emit(deathCounter);

func _process(_delta):
	if(!isTimerStarted):
		timer.start();
		isTimerStarted = true;

func incrementElapsedTime():
	elapsedTime += timer.wait_time;

func onLevelEnd():
	timer.stop();

func collectibleFound():
	collectiblesFound += 1;
	collectible_found_changed.emit(collectiblesFound);

func setCollectiblesAvailable(_collectiblesAvailable):
	collectiblesAvailable = _collectiblesAvailable;
	collectible_available_changed.emit(collectiblesAvailable);

