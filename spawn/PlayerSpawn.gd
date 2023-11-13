extends Node2D

class_name PlayerSpawn

signal change_player_spawn

func spawnPlayer(levelNode : Node, playerScene):
	var createdPlayer = playerScene.instantiate();
	levelNode.add_child.call_deferred(createdPlayer);
	createdPlayer.position = position;

func _body_entered(body):
	print("body entered spawn point");
	if body.is_in_group("Player"):
		print("player entered spawn point");
		emit_signal("change_player_spawn", self);
	
