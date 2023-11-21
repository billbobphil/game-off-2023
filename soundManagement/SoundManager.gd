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

func playAbilityUnlock():
	var player = univeralAudioSource.get_node("AbilityUnlock");
	if player and not player.playing:
		player.play();

func playInteractSuccessful():
	var player = univeralAudioSource.get_node("InteractSuccessful");
	if player and not player.playing:
		player.play();

func playDash():
	var player = univeralAudioSource.get_node("DashPlayer");
	if player and not player.playing:
		player.play();

func playCollectiblePickup():
	var player = univeralAudioSource.get_node("CollectiblePickupPlayer");
	if player and not player.playing:
		player.play();

func playGrow():
	var player = univeralAudioSource.get_node("GrowPlayer");
	if player and not player.playing:
		player.play();

func playShrink():
	var player = univeralAudioSource.get_node("ShrinkPlayer");
	if player and not player.playing:
		player.play();