extends State

@export_category("Components")
@export var inputs:Inputs 
@export var controller:FPS_Controller 
@export var camera:VirtualCamera 



@export_category("Values")
@export var speed:float = 30
@export var fov:float = 90


func On_Enter(_sm)-> bool:
	create_tween().tween_property(camera,"FOV",fov,0.2)
	return true

func On_Exit(_sm)-> bool:
	return true
	
func On_Update(sm,_delta) -> bool:
	return true
	
func On_Physic_Update(_sm,delta) -> bool:
	controller.Look(inputs.Look_Vector,80,delta)
	controller.ApplyGravity(9.81,delta)
	controller.Move(inputs.Move_Vector,speed,delta)
	return true
