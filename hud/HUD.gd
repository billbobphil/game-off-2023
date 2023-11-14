extends CanvasLayer

@onready var deathCounterLabel = $DeathCounterLabel;

func _ready():
	for statTracker in get_tree().get_nodes_in_group("StatTracker"):
		statTracker.death_count_changed.connect(incrementDeathCounter);

func incrementDeathCounter(newCount):
	deathCounterLabel.text = str(newCount);
