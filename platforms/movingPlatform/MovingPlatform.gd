extends Node2D

@onready var platform : CharacterBody2D = get_node("Platform")
@export var startNode : Node2D;
@export var endNode : Node2D;
var movingTowardsNode : Node2D;
@export var speed : float = 100;

func _ready():
	movingTowardsNode = startNode;

func _physics_process(_delta):
	var direction = (movingTowardsNode.global_position - platform.global_position).normalized();
	platform.velocity = direction * speed;
	platform.move_and_slide();
	# platform.position += direction * delta * 100;

	if movingTowardsNode.global_position.distance_to(platform.global_position) < 1:
		if movingTowardsNode == startNode:
			movingTowardsNode = endNode;
		else:
			movingTowardsNode = startNode;
