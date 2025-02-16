class_name HackingNode
extends Area2D

@onready var text:RichTextLabel = $reward_text


var reward:int = 10:
	set(value): 
		reward = value 
		_update_text()

	
func _on_area_entered(area: Area2D) -> void:
	if area is HackingArrow:
		area.enter_hacking_node(self)

func _update_text() -> void:
		if (!text): 
			return
		text.text = "" if reward == 0 else "[center]"+ str(reward) +"[/center]"
