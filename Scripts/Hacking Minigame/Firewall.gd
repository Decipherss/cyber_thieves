@tool
class_name Firewall
extends Area2D

@export var Center:Node2D
@export var Distance:float = 10
@export var Speed:float = 10

var time:float = 0
func _process(delta: float) -> void:	
	if !Center:
		return
	
	time = fmod(time + delta * Speed,1.0)
	var pos_x = cos(TAU * time) * Distance
	var pos_y = sin(TAU * time) * Distance
	global_position = Center.global_position + Vector2(pos_x,pos_y)
	look_at(Center.global_position)


func _on_area_entered(area: Area2D) -> void:
	if area  is HackingArrow:
		area.enter_firewall(self)
