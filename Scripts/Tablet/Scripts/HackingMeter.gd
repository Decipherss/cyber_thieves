class_name HackingMeter
extends Node

enum Value{low = 1,mid = 2,high = 3}

@onready var low:Node2D = $Low
@onready var mid:Node2D = $Mid
@onready var high:Node2D = $High

func set_meter(value:Value):
	match(value):
		Value.low:
			low.show()
			mid.hide()
			high.hide()
		Value.mid:
			low.hide()
			mid.show()
			high.hide()
		Value.high:
			low.hide()
			mid.hide()
			high.show()
			
