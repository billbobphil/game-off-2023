extends CanvasLayer

class_name LevelSummaryScreen

@onready var deathText : Label = get_node("Deaths/Label");
@onready var minutesText : Label = get_node("Timer/Minutes");
@onready var secondsText : Label = get_node("Timer/Seconds");
@onready var millisecondsText : Label = get_node("Timer/Milliseconds");
@export var statsTracker : StatsTracker;

# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false;

func _process(_delta):
	if (self.visible && Input.is_action_just_pressed("jump")):
		on_next_level_button_pressed();

func _on_level_end():
	showLevelEndScreen();

func showLevelEndScreen():
	self.visible = true;
	deathText.text = str(statsTracker.deathCounter);
	var minutes = int(statsTracker.elapsedTime / 60);
	var seconds = int(statsTracker.elapsedTime) % 60;
	var milliseconds = int((statsTracker.elapsedTime - int(statsTracker.elapsedTime)) * 1000);

	minutesText.text = "%02d" % [minutes];
	secondsText.text = "%02d" % [seconds];
	millisecondsText.text = "%03d" % [milliseconds];

func on_next_level_button_pressed():
	print("go to next level");
	get_tree().call_group("LevelMounter", "nextLevel");


