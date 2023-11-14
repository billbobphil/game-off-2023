extends Node2D

class_name CameraTransitionGroup

@export var transitions : Array[CameraTransition]

@export var cameraXPosition : float;
@export var cameraYPosition : float;

func _ready():
	for transition in transitions:
		transition.newXPosition = cameraXPosition;
		transition.newYPosition = cameraYPosition;