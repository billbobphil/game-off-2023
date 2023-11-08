extends Node2D

class_name PlayerSpawn

var playerScene = preload("res://player/player.tscn").instantiate();

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().add_child.call_deferred(playerScene);
	playerScene.position = position;
	