extends State

@export_category("Components")
@export var controller:FPS_Controller 
@export var camera:VirtualCamera 

@export_category("Values")
@export var speed:float = 30
@export var fov:float = 90

@onready var tablet:Tablet =$"../../Virtual Camera/Tablet"
@onready var tablet_anim:AnimationPlayer = $"../../AnimationPlayer"

var hidden = true

func On_Enter(_sm)-> bool:
	create_tween().tween_property(camera,"FOV",fov,0.2)
	return true

func On_Exit(_sm)-> bool:
	return true
	
func On_Update(_sm,_delta) -> bool:
	if(Inputs.Show_Tablet):
		hidden = !hidden
		if(hidden):
			tablet_anim.play("show")
		else:
			tablet_anim.play("hide")
	
	return true
	
func On_Physic_Update(_sm,delta) -> bool:
	controller.Look(Inputs.Look_Vector,80,delta)
	controller.ApplyGravity(9.81,delta)
	controller.Move(Inputs.Move_Vector,speed,delta)
	return true
