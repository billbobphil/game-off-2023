extends Node

@export var isDashEnabled : bool = false;
@export var isScaleUpEnabled : bool = false;
@export var isScaleDownEnabled : bool = false;

enum Abilities {
	DASH,
	SCALE_UP,
	SCALE_DOWN
}

@export var abilityDictionary = {
	Abilities.DASH : {
		"name" : "DASH",
		"pcTexturePath" : "res://genericUi/inputIcons/keyboard/Ctrl_Key_Light.png",
		"xboxTexturePath" : "res://genericUi/inputIcons/xbox/XboxSeriesX_RT.png",
		"playstationTexturePath" : "res://genericUi/inputIcons/playstation/PS5_R2.png"
	},
	Abilities.SCALE_UP : {
		"name" : "GROW",
		"pcTexturePath" : "res://genericUi/inputIcons/keyboard/E_Key_Light.png",
		"xboxTexturePath" : "res://genericUi/inputIcons/xbox/XboxSeriesX_RB.png",
		"playstationTexturePath" : "res://genericUi/inputIcons/playstation/PS5_R1.png"
	},
	Abilities.SCALE_DOWN : {
		"name" : "SHRINK",
		"pcTexturePath" : "res://genericUi/inputIcons/keyboard/Q_Key_Light.png",
		"xboxTexturePath" : "res://genericUi/inputIcons/xbox/XboxSeriesX_LB.png",
		"playstationTexturePath" : "res://genericUi/inputIcons/playstation/PS5_L1.png"
	}
}

func enableAbility(ability : Abilities):
	if(ability == Abilities.DASH):
		print("Enabling DASH");
		isDashEnabled = true
	elif(ability == Abilities.SCALE_UP):
		print("Enabling SCALE_UP");
		isScaleUpEnabled = true
	elif(ability == Abilities.SCALE_DOWN):
		print("Enabling SCALE_DOWN");
		isScaleDownEnabled = true