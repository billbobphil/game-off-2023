extends Node

@onready var univeralAudioSource = get_tree().root.get_node("Root/UniversalAvailableAudio");

func playFootsteps():
	var player = get_tree().get_nodes_in_group("Player")[0].get_node("FootstepsPlayer");
	if player and not player.playing:
		player.play();

func stopFootsteps():
	var player = get_tree().get_nodes_in_group("Player")[0].get_node("FootstepsPlayer");
	if player and player.playing:
		player.stop();

func playJump():
	var player = get_tree().get_nodes_in_group("Player")[0].get_node("JumpPlayer");
	if player and not player.playing:
		player.play();

func playDialogAccept(player : AudioStreamPlayer2D):
	player.play();

func playDeath():
	var player = univeralAudioSource.get_node("PlayerDeathPlayer");
	if player and not player.playing:
		player.play();

