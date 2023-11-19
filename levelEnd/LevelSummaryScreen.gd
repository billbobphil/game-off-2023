extends CanvasLayer

class_name LevelSummaryScreen

@onready var deathText : Label = get_node("Deaths/Label");
@onready var minutesText : Label = get_node("Timer/Minutes");
@onready var secondsText : Label = get_node("Timer/Seconds");
@onready var millisecondsText : Label = get_node("Timer/Milliseconds");
@onready var collectedLabel : Label = get_node("Secrets/CollectedLabel");
@onready var totalLabel : Label = get_node("Secrets/TotalLabel");
@onready var devTimeLabel : Label = get_node("DevTime");

@export var statsTracker : StatsTracker;
@export var devTime : String = "00:00:000";

# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false;

func _process(_delta):
	if(self.visible):
		if (Input.is_action_just_pressed("jump") || Input.is_action_just_pressed("acknowledge_dialog")):
			on_next_level_button_pressed();
		if(Input.is_action_just_pressed("restart")):
			on_restart_level_button_pressed();

func _on_level_end():
	showLevelEndScreen();

func showLevelEndScreen():
	self.visible = true;
	deathText.text = str(statsTracker.deathCounter);

	collectedLabel.text = str(statsTracker.collectiblesFound);
	totalLabel.text = str(statsTracker.collectiblesAvailable);

	var minutes = int(statsTracker.elapsedTime / 60);
	var seconds = int(statsTracker.elapsedTime) % 60;
	var milliseconds = int((statsTracker.elapsedTime - int(statsTracker.elapsedTime)) * 1000);

	minutesText.text = "%02d" % [minutes];
	secondsText.text = "%02d" % [seconds];
	millisecondsText.text = "%03d" % [milliseconds];

	devTimeLabel.text = devTime;

func on_next_level_button_pressed():
	get_tree().call_group("LevelMounter", "nextLevel");

func on_restart_level_button_pressed():
	get_tree().call_group("LevelMounter", "restartLevel");

