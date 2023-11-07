extends Node2D

@onready var camera = $Camera;

# Called when the node enters the scene tree for the first time.
func _ready():
	var cameraTransitions  = get_tree().get_nodes_in_group("CameraTransition");
	for transition in cameraTransitions:
		transition.move_camera.connect(camera._on_area_2d_move_camera);
