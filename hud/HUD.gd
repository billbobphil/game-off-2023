extends CanvasLayer

@onready var deathCounterLabel = $DeathCounterLabel;
@onready var collectibleCounterLabel = $CollectibleCounterLabel;
@onready var totalCollectibleCounterLabel = $TotalCollectibleCounterLabel;


func incrementDeathCounter(newCount):
	deathCounterLabel.text = str(newCount);

func incrementCollectibleCounter(newCount):
	collectibleCounterLabel.text = str(newCount);

func incrementTotalCollectibleCounter(newCount):
	totalCollectibleCounterLabel.text = str(newCount);

func on_new_level_loaded():
	deathCounterLabel.text = "0";
	collectibleCounterLabel.text = "0";
	totalCollectibleCounterLabel.text = "0";
	for statTracker in get_tree().get_nodes_in_group("StatTracker"):
		statTracker.death_count_changed.connect(incrementDeathCounter);
		statTracker.collectible_found_changed.connect(incrementCollectibleCounter);
		statTracker.collectible_available_changed.connect(incrementTotalCollectibleCounter);
