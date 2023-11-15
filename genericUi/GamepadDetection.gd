extends Node

enum InputType {
	XBOX,
	PLAYSTATION,
	KEYBOARD
}

var currentInputType : InputType = InputType.KEYBOARD;

func _input(event):
	#if we see performance issues could introduce this line to only change on very specific but common inputs
	# if event.is_action_released("jump") || event.is_action_released("acknowledge_dialog"):
	if(event is InputEventJoypadButton or event is InputEventJoypadMotion):
		var inputName = Input.get_joy_name(event.device)
		if("playstation" in inputName.to_lower() || "dualshock" in inputName.to_lower()):
			changeInputType(InputType.PLAYSTATION);
		else:
			changeInputType(InputType.XBOX);
	elif event is InputEventKey or event is InputEventMouseMotion or event is InputEventMouseButton:
		changeInputType(InputType.KEYBOARD);
	print(currentInputType);

func changeInputType(inputType : InputType):
	if(currentInputType != inputType):
		currentInputType = inputType;
		var dialogNodes = get_tree().get_nodes_in_group("DialogSystems");
		for dialogNode in dialogNodes:
			dialogNode.inputTypeChanged();
		
