extends CanvasLayer

var deathCounter = 0;
@onready var deathCounterLabel = $DeathCounterLabel;

func _ready():
	for deathPlane in get_tree().get_nodes_in_group("deathPlanes"):
		deathPlane.kill_player.connect(incrementDeathCounter);

func incrementDeathCounter(_body):
	deathCounter += 1;
	deathCounterLabel.text = str(deathCounter);
