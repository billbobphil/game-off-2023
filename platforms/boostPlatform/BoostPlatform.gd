extends Node2D

var playerRef = null;
@export var forceToApply : float = -10;

func on_body_enter(body):
	if body.is_in_group("Player"):
		playerRef = body

func on_body_exit(body):
	if body.is_in_group("Player"):
		playerRef = null

func _physics_process(delta):
	if playerRef != null:
		playerRef.velocity += Vector2(0, forceToApply) * delta;
