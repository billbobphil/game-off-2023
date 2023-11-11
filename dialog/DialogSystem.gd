extends Node2D

@export var dialogLines : Array[String];
@export var isDialogIndexTriggered : Array[bool];
var dialogHasBeenTriggered : Array[bool];
var dialogIndex : int = 0;
var isDialogActive : bool = false;
var canDialogBeMadeActive : bool = true;
var isDialogNextShown : bool = false;
@onready var nextIcon : Node2D = $NextIcon;

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
	setShouldShowDialogNext();

func _process(_delta):
	if(isDialogActive):
		if(Input.is_action_just_pressed("acknowledge_dialog")):
			if(dialogIndex < dialogLines.size() - 1):
				if(!isDialogIndexTriggered[dialogIndex + 1]):
					dialogIndex += 1;
					setDialogText(dialogLines[dialogIndex]);
			else:
				isDialogActive = false;
				setDialogText("");
			setShouldShowDialogNext();

func setDialogText(text : String):
	$DialogLabel.text = text;

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
