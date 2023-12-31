extends Node2D

class_name SpawnManager

@export var activeSpawnPoint : PlayerSpawn;
var playerScene = preload("res://player/player.tscn");

func _ready():
	if(activeSpawnPoint == null):
		activeSpawnPoint = get_tree().get_nodes_in_group("spawnPoints")[0];
	activeSpawnPoint.spawnPlayer(get_parent(), playerScene);
	for deathPlane in get_tree().get_nodes_in_group("deathPlanes"):
		deathPlane.kill_player.connect(respawnPlayer);
	
	for spawnPoint in get_tree().get_nodes_in_group("spawnPoints"):
		spawnPoint.change_player_spawn.connect(assignNewSpawnPoint);

func assignNewSpawnPoint(newSpawnPoint : PlayerSpawn):
	activeSpawnPoint = newSpawnPoint;

func respawnPlayer(_body):
	await get_tree().create_timer(.3).timeout;
	activeSpawnPoint.spawnPlayer(get_parent(), playerScene);
