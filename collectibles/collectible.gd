extends Node2D

signal collectible_found

func _on_area_2d_body_entered(body:Node2D):
	if(body.name == "Player"):
		collectible_found.emit();
		SoundManager.playCollectiblePickup();
		queue_free()

