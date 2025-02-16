extends State

@export_category("Components")
@export var controller:FPS_Controller 
@export var camera:VirtualCamera 

@export var fov:float = 50

@onready var tablet_anim:AnimationPlayer = $"../../AnimationPlayer"
@onready var move_state:State = $"../Move"
@onready var tablet:Tablet =$"../../Virtual Camera/Tablet"

func On_Enter(_sm)-> bool:
	create_tween().tween_property(camera,"FOV",fov,0.2)
	tablet_anim.play("show")
	return true

func On_Exit(_sm)-> bool:
	tablet_anim.play("hide")
	return true
	
func On_Update(_sm,_delta) -> bool:	
	if(!tablet.is_hacking):
		return _sm.Change_State(move_state)
	return true
	
	
func On_Physic_Update(_sm,delta) -> bool:
	controller.ApplyGravity(9.81,delta)
	return true
