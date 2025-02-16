class_name HackingEnd
extends Area2D


func _on_area_entered(area: Area2D) -> void:
	if area is HackingArrow:
		area.enter_end_node(self)
