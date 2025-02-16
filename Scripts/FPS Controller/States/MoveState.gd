extends State

@export_category("Components")
@export var controller:FPS_Controller 
@export var camera:VirtualCamera 

@export_category("Values")
@export var speed:float = 30
@export var fov:float = 90

@onready var tablet:Tablet =$"../../Virtual Camera/Tablet"
@onready var tablet_anim:AnimationPlayer =$"../../AnimationPlayer"
@onready var raycast:RayCast3D = $"../../Virtual Camera/RayCast3D"
@onready var idle_state:State = $"../Idle"


var hidden = true:
	set(value):
		hidden = value
		update_tablet()

func On_Enter(_sm)-> bool:
	create_tween().tween_property(camera,"FOV",fov,0.2)
	update_tablet()
	return true

func On_Exit(_sm)-> bool:
	return true
	
func On_Update(_sm,_delta) -> bool:
	var npc:NPC = raycast.get_collider() as NPC
	
	if(npc && Inputs.Hack):
		tablet.start_scan(npc)
		
	if(tablet.is_hacking):
		return _sm.Change_State(idle_state)
	
	if(Inputs.Show_Tablet):
		hidden = !hidden
		
	return true
	
func On_Physic_Update(_sm,delta) -> bool:
	controller.Look(Inputs.Look_Vector,80,delta)
	controller.ApplyGravity(9.81,delta)
	controller.Move(Inputs.Move_Vector,speed,delta)
	return true
	
func update_tablet():
		if(hidden):
			tablet_anim.play("show")
		else:
			tablet_anim.play("hide")
	
