extends Node2D
	
#TODO: let controller interact with the buttons!
#TODO: maybe button hover effects
#TODO: buttons for level select -> REMEMBER TO PUT A SCRIPT INTO EACH LEVEL TO ENSURE THE CORRECT ABILITIES HAVE BEEN TURNED ON

func _on_play_pressed():
	SoundManager.playInteractSuccessful();
	get_tree().call_group("LevelMounter", "goToLevelIndex", 2);
	
func _on_credits__pressed():
	SoundManager.playInteractSuccessful();
	get_tree().call_group("LevelMounter", "goToLevelIndex", 1);
