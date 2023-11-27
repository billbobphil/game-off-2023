extends Node2D

@export var isDashEnabled : bool;
@export var isScaleUpEnabled : bool;
@export var isScaleDownEnabled : bool;

func _ready():
	AbilityFlags.isDashEnabled = isDashEnabled;
	AbilityFlags.isScaleUpEnabled = isScaleUpEnabled;
	AbilityFlags.isScaleDownEnabled = isScaleDownEnabled;
	StatsTotals.reset();