extends Area2D

class_name DeathPlane

signal kill_player

func _on_Area2D_body_entered(body):
	print("body entered death plane");
	if body.is_in_group("Player"):
		print("body in death plane was player");
		emit_signal("kill_player", body)