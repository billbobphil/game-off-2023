extends Node

@export var isDashEnabled : bool = false;
@export var isScaleUpEnabled : bool = false;
@export var isScaleDownEnabled : bool = false;

enum Abilities {
	DASH,
	SCALE_UP,
	SCALE_DOWN
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