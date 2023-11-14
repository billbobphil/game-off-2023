extends AnimatedSprite2D

class_name  LevelEnd

signal level_end

func _ready():
	pass

func _on_body_entered(body):
	if body.is_in_group("Player"):
		print("player collided with level end")
		level_end.emit();
		get_tree().paused = true;
		self.queue_free();