class_name HackingBorder
extends Area2D

func _on_area_exited(area: Area2D) -> void:
	if area is HackingArrow:
		area.exit_border(self)
