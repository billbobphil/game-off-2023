extends Node2D

class_name SpawnManager

@export var activeSpawnPoint : PlayerSpawn;
var playerScene = preload("res://player/player.tscn");

func _ready():
	activeSpawnPoint.spawnPlayer(get_parent(), playerScene);
	for deathPlane in get_tree().get_nodes_in_group("deathPlanes"):
		deathPlane.kill_player.connect(respawnPlayer);
	
	for spawnPoint in get_tree().get_nodes_in_group("spawnPoints"):
		spawnPoint.change_player_spawn.connect(assignNewSpawnPoint);

func assignNewSpawnPoint(newSpawnPoint : PlayerSpawn):
	print("player spawn changed");
	activeSpawnPoint = newSpawnPoint;

func respawnPlayer(_body):
	print("trying to respawn player");
	activeSpawnPoint.spawnPlayer(get_parent(), playerScene);
