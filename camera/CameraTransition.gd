extends Area2D

class_name CameraTransition

@export var newXPosition : float;
@export var newYPosition : float;

signal move_camera(newXPosition, newYPosition)

func _on_body_entered(body):
	if(body.name == "Player"):
		move_camera.emit(newXPosition, newYPosition);
