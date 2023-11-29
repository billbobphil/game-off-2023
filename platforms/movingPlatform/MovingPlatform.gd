extends Node2D

@onready var pathFollow : PathFollow2D = get_node("Path2D/PathFollow2D");
@export var speed : float;
@export var shouldRandomizeStartLocation : bool;

func _ready():
	if(shouldRandomizeStartLocation):
		pathFollow.progress_ratio = randf();

func _process(delta):
	pathFollow.progress += speed * delta
