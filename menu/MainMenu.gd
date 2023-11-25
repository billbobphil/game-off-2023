extends Node2D
	
#TODO: let controller interact with the buttons!
#TODO: maybe button hover effects
#TODO: [STRETCH] buttons for level select -> REMEMBER TO PUT A SCRIPT INTO EACH LEVEL TO ENSURE THE CORRECT ABILITIES HAVE BEEN TURNED ON

@onready var playButton : Button = get_node("CanvasLayer/PlayButton");
@onready var creditsButton : Button = get_node("CanvasLayer/CreditsButton");
var wasButtonSelected : bool = false;

func _ready():
	playButton.grab_focus();

func _on_play_pressed():
	wasButtonSelected = true;
	SoundManager.playInteractSuccessful();
	get_tree().call_group("LevelMounter", "goToLevelIndex", 2);
	
func _on_credits__pressed():
	wasButtonSelected = true;
	SoundManager.playInteractSuccessful();
	get_tree().call_group("LevelMounter", "goToLevelIndex", 1);

func _on_button_focused():
	if(!wasButtonSelected):
		SoundManager.playButtonFocus();