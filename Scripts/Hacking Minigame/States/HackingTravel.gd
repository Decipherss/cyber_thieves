extends State

@export var Travel_Speed:float = 10
@export var Aim_State:State 

@onready var Arrow:Area2D = $"../.."

func On_Enter(_sm)-> bool:
	return true

func On_Exit(_sm)-> bool:
	return true
	
func On_Update(sm,_delta) -> bool:	
	return true
	
func On_Physic_Update(_sm,delta) -> bool:
	Arrow.global_position += Arrow.transform.x * Travel_Speed
	return true
