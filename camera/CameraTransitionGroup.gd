extends Node2D

class_name CameraTransitionGroup

@export var transitions : Array[CameraTransition]

@export var cameraXPosition : float;
@export var cameraYPosition : float;

func _ready():
	var children = get_children();
	for child in children:
		if child is CameraTransition:
			transitions.append(child);

	for transition in transitions:
		transition.newXPosition = cameraXPosition;
		transition.newYPosition = cameraYPosition;
