extends Node

class_name StatsTracker

signal death_count_changed

var deathCounter = 0;
@onready var timer : Timer = $Timer;
var isTimerStarted = false;
var elapsedTime : float = 0;

func _ready():
	for deathPlane in get_tree().get_nodes_in_group("deathPlanes"):
		deathPlane.kill_player.connect(incrementDeathCounter);
	
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
