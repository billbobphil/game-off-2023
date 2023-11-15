extends Area2D

class_name DeathPlane

signal kill_player

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("kill_player", body)