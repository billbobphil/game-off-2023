extends Sprite2D

@export var animationToPlay : String = "hover";
@onready var animationPlayer : AnimationPlayer = $AnimationPlayer;

func _ready():
	animationPlayer.current_animation = animationToPlay;
	animationPlayer.play();
