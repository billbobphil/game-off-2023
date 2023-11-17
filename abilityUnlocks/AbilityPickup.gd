extends AnimatedSprite2D

@export var abilityToGive : AbilityFlags.Abilities;

func giveAbility(body):
	if(body.name == "Player"):
		AbilityFlags.enableAbility(abilityToGive);