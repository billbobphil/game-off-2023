extends Node2D

@onready var menuButton : Button = get_node("CanvasLayer/CreditsButton");

func _ready():
	menuButton.grab_focus();

func _on_menu_press():
	SoundManager.playInteractSuccessful();
	get_tree().call_group("LevelMounter", "goToLevelIndex", 1);
