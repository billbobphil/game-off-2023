extends Node2D

@onready var challengeButton : Button = get_node("CanvasLayer/ChallengeButton");
@onready var deathText : Label = get_node("CanvasLayer/Deaths/Label");
@onready var hoursText : Label = get_node("CanvasLayer/Timer/Hours");
@onready var minutesText : Label = get_node("CanvasLayer/Timer/Minutes");
@onready var secondsText : Label = get_node("CanvasLayer/Timer/Seconds");
@onready var millisecondsText : Label = get_node("CanvasLayer/Timer/Milliseconds");
@onready var collectedLabel : Label = get_node("CanvasLayer/Secrets/CollectedLabel");
@onready var totalLabel : Label = get_node("CanvasLayer/Secrets/TotalLabel");
var wasButtonSelected = false;

func _ready():
	challengeButton.grab_focus();
	deathText.text = str(StatsTotals.totalDeaths);

	collectedLabel.text = "%02d" % StatsTotals.totalCollectiblesFound;
	totalLabel.text = "%02d" % StatsTotals.totalCollectiblesAvailable;

	# collectedLabel.text = str(StatsTotals.totalCollectiblesFound);
	# totalLabel.text = str(StatsTotals.totalCollectiblesAvailable);

	var hours = int(StatsTotals.totalTime / 3600)
	var minutes = int(StatsTotals.totalTime / 60) % 60
	var seconds = int(StatsTotals.totalTime) % 60
	var milliseconds = int((StatsTotals.totalTime - int(StatsTotals.totalTime)) * 1000)

	hoursText.text = "%02d" % [hours];
	minutesText.text = "%02d" % [minutes];
	secondsText.text = "%02d" % [seconds];
	millisecondsText.text = "%03d" % [milliseconds];

func _on_button_focused():
	if(!wasButtonSelected):
		SoundManager.playButtonFocus();

func _on_challenge_pressed():
	wasButtonSelected = true;
	SoundManager.playInteractSuccessful();
	get_tree().call_group("LevelMounter", "nextLevel");

func _on_quit_pressed():
	wasButtonSelected = true;
	SoundManager.playInteractSuccessful();
	get_tree().quit();
