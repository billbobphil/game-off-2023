extends Node2D

@export var isDashEnabled : bool;
@export var isScaleUpEnabled : bool;
@export var isScaleDownEnabled : bool;
@export var shouldResetStats : bool;

func _ready():
	AbilityFlags.isDashEnabled = isDashEnabled;
	AbilityFlags.isScaleUpEnabled = isScaleUpEnabled;
	AbilityFlags.isScaleDownEnabled = isScaleDownEnabled;
	if(shouldResetStats):
		StatsTotals.reset();