extends AnimatedSprite2D

@export var abilityToGive : AbilityFlags.Abilities;
@onready var unlockCanvas : CanvasLayer = get_node("UnlockCanvas");
var isActive : bool = false;

func _ready():
	unlockCanvas.hide();

func giveAbility(body):
	if(body.name == "Player"):
		get_tree().paused = true;
		isActive = true;
		var area : Area2D = get_node("Area2D");
		area.set_process(false);
		area.collision_layer = 0;
		area.collision_mask = 0;

		AbilityFlags.enableAbility(abilityToGive);
		unlockCanvas.show();

		SoundManager.playAbilityUnlock();

		var icon : Sprite2D = unlockCanvas.get_node("AbilityIcon");
		var abilityText : Label = unlockCanvas.get_node("AbilityLabel");
		if(GamepadDetection.currentInputType == GamepadDetection.InputType.KEYBOARD):
			icon.texture = load(AbilityFlags.abilityDictionary[abilityToGive].pcTexturePath);
		elif(GamepadDetection.currentInputType == GamepadDetection.InputType.XBOX):
			icon.texture = load(AbilityFlags.abilityDictionary[abilityToGive].xboxTexturePath);
		else:
			icon.texture = load(AbilityFlags.abilityDictionary[abilityToGive].playstationTexturePath);

		abilityText.text = AbilityFlags.abilityDictionary[abilityToGive].name + " UNLOCKED";

func _process(_delta):
	if(!isActive): return;

	if(Input.is_action_just_pressed("jump") || Input.is_action_just_pressed("acknowledge_dialog")):
		continueGame();

func continueGame():
	SoundManager.playInteractSuccessful();
	unlockCanvas.hide();
	get_tree().paused = false;
	isActive = false;
	queue_free();



