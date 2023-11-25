extends Node2D

@onready var backButton : Button = get_node("CanvasLayer/BackButton");

func _ready():
	backButton.grab_focus();

func _on_back_pressed():
	SoundManager.playInteractSuccessful();
	get_tree().call_group("LevelMounter", "goToLevelIndex", 0);
