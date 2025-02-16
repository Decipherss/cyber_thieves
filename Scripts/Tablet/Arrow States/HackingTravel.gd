extends State

@export var Travel_Speed:float = 10
@export var Aim_State:State 

@onready var Arrow:Area2D = $"../.."

func On_Enter(_sm)-> bool:
	return true

func On_Exit(_sm)-> bool:
	return true
	
func On_Update(sm,_delta) -> bool:	
	if(Inputs.Hack):
		return sm.Change_State(Aim_State)
	return true
	
func On_Physic_Update(_sm,_delta) -> bool:
	Arrow.global_position += Arrow.transform.x * Travel_Speed * _delta
	return true
