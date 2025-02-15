extends State

@export var Distance_from_center:float = 10
@export var Travel_State:State 

@onready var Arrow:Node2D = $"../.."

var direction:Vector2 = Vector2(0,1)
var position:Vector2 = Vector2(0,0)

func _ready() -> void:
	position = Arrow.global_position
	
func On_Enter(_sm)-> bool:
	Arrow.global_position = position
	return true

func On_Exit(_sm)-> bool:
	return true
	
func On_Update(_sm,_delta) -> bool:
	if(Inputs.Hack):
		return _sm.Change_State(Travel_State)
	return true
	
func On_Physic_Update(_sm,_delta) -> bool:
	var mouse_dir = Inputs.Mouse_Velocity
	mouse_dir.y *= -1
	if(mouse_dir.length() > 0.1):
		direction = direction.slerp(mouse_dir.normalized(),1-exp(-5 * _delta))
	
	Arrow.global_position = position + direction * Distance_from_center
	Arrow.look_at(Arrow.global_position + direction)
	return true
