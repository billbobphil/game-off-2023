extends Node2D

@export var dialogLines : Array[String];
@export var isDialogIndexTriggered : Array[bool];
@export var dialogInputIconPC : Array[Texture];
@export var dialogInputIconPlaystation : Array[Texture];
@export var dialogInputIconXbox : Array[Texture];
var dialogHasBeenTriggered : Array[bool];
var dialogIndex : int = 0;
var isDialogActive : bool = false;
var canDialogBeMadeActive : bool = true;
var isDialogNextShown : bool = false;
@onready var nextIcon : Node2D = get_node("CanvasLayer/NextIcon");
@onready var dialogLabel : Label = get_node("CanvasLayer/DialogLabel");
@onready var inputIcon : Sprite2D = get_node("CanvasLayer/InputIcon");

func _ready():
	nextIcon.visible = false;
	dialogHasBeenTriggered.resize(dialogLines.size());
	for i in range(dialogHasBeenTriggered.size()):
		dialogHasBeenTriggered[i] = false;
		
	setDialogText("");

func startDialogTrigger(body):
	if(body.name != "Player"):
		return;

	if(canDialogBeMadeActive):
		startDialog();
		canDialogBeMadeActive = false;

func startDialog():
	isDialogActive = true;
	dialogIndex = 0;
	setDialogText(dialogLines[dialogIndex]);
	controlInputIcon();
	canDialogBeMadeActive = false;
	setShouldShowDialogNext();

func oneTimeTriggerDialogChange(body, index):
	if(body.name != "Player" || !isDialogActive):
		return;

	if(dialogHasBeenTriggered[index]):
		return;

	dialogIndex = index;
	dialogHasBeenTriggered[dialogIndex] = true;
	setDialogText(dialogLines[dialogIndex]);
	controlInputIcon();
	setShouldShowDialogNext();

func _process(_delta):
	if(isDialogActive):
		if(Input.is_action_just_pressed("acknowledge_dialog")):
			if(dialogIndex < dialogLines.size() - 1):
				if(!isDialogIndexTriggered[dialogIndex + 1]):
					dialogIndex += 1;
					setDialogText(dialogLines[dialogIndex]);
					controlInputIcon();
					SoundManager.playDialogAccept($AudioStreamPlayer2D);
			else:
				isDialogActive = false;
				setDialogText("");
				SoundManager.playDialogAccept($AudioStreamPlayer2D);
				inputIcon.visible = false;
			setShouldShowDialogNext();

func setDialogText(text : String):
	dialogLabel.text = text;

func setShouldShowDialogNext():

	if(!isDialogActive):
		nextIcon.visible = false;
		return;

	if(dialogIndex < dialogLines.size() - 1):
		if(!isDialogIndexTriggered[dialogIndex + 1]):
			nextIcon.visible = true;
		else:
			nextIcon.visible = false;
	else:
		if(dialogIndex == dialogLines.size() - 1):
			nextIcon.visible = true;
		else:
			nextIcon.visible = false;

func controlInputIcon():

	var dialogInputIcons : Array[Texture];

	if(GamepadDetection.currentInputType == GamepadDetection.InputType.KEYBOARD):
		dialogInputIcons = dialogInputIconPC;
	elif(GamepadDetection.currentInputType == GamepadDetection.InputType.PLAYSTATION):
		dialogInputIcons = dialogInputIconPlaystation;
	elif(GamepadDetection.currentInputType == GamepadDetection.InputType.XBOX):
		dialogInputIcons = dialogInputIconXbox;

	if(dialogIndex < dialogInputIcons.size() && dialogInputIcons[dialogIndex] != null):
		inputIcon.texture = dialogInputIcons[dialogIndex];
		inputIcon.visible = true;
	else:
		inputIcon.visible = false;


func inputTypeChanged():
	controlInputIcon();