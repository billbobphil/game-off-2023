extends AnimatedSprite2D

@onready var light = $Light;

# Set the range for the flicker effect.
@export var min_energy = 0.8
@export var max_energy = 1.2

# Set the minimum and maximum interval in seconds for the flicker effect.
@export var min_interval = 0.05
@export var max_interval = 0.2

# Timer for the flicker effect.
var flicker_timer = 0.0

func _ready():
    # Initialize the flicker effect.
    flicker_timer = randf_range(min_interval, max_interval)
    # Set the process function to be called every frame.
    set_process(true)

func _process(delta):
    flicker_timer -= delta
    if flicker_timer <= 0:
        # When the timer runs out, change the light's energy.
        light.energy = randf_range(min_energy, max_energy)
        # Reset the timer.
        flicker_timer = randf_range(min_interval, max_interval)