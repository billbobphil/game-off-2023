extends Camera2D


func _on_area_2d_move_camera(newXPosition : float, newYPosition : float):
	#TODO: tween??
	position.x = newXPosition;
	position.y = newYPosition;

	
