extends Camera2D


func _ready():
	print("Camera2D ready");
	print("Camera2D position: ", position);

func _on_area_2d_move_camera(newXPosition : float, newYPosition : float):
	#TODO: tween??
	position.x = newXPosition;
	position.y = newYPosition;

	
