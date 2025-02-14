class_name State extends Node

func On_Enter(_sm:StateMachine)-> bool:
	return true
func On_Update(_sm:StateMachine,_delta:float) -> bool:
	return true
func On_Physic_Update(_sm:StateMachine,_delta:float) -> bool:
	return true
func On_Exit(_sm:StateMachine)-> bool:
	return true
