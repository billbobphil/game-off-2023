extends Node2D

@export var dialogLines : Array[String];
@export var isDialogIndexTriggered : Array[bool];
var dialogHasBeenTriggered : Array[bool];
var dialogIndex : int = 0;
var isDialogActive : bool = false;

func _ready():
	dialogHasBeenTriggered.resize(dialogLines.size());
	for i in range(dialogHasBeenTriggered.size()):
		dialogHasBeenTriggered[i] = false;
		
	setDialogText("");
	startDialog()

func startDialog():
	isDialogActive = true;
	dialogIndex = 0;
	setDialogText(dialogLines[dialogIndex]);

func oneTimeTriggerDialogChange(body, index):
	if(body.name != "Player"):
		return;

	if(dialogHasBeenTriggered[index]):
		return;

	dialogIndex = index;
	dialogHasBeenTriggered[dialogIndex] = true;
	setDialogText(dialogLines[dialogIndex]);

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
				
			
		# if(Input.is_action_just_pressed("acknowledge_dialog") && !isDialogIndexTriggered[dialogIndex + 1]):
		# 	if(dialogIndex < dialogLines.size() - 1):
		# 		dialogIndex += 1;
		# 		setDialogText(dialogLines[dialogIndex]);
		# 	else:
		# 		isDialogActive = false;
		# 		setDialogText("");

func setDialogText(text : String):
	$DialogLabel.text = text;
