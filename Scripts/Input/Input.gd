class_name Inputs extends Node


var Move_Vector:Vector2:
	get:return GetVector("Move_Left","Move_Right","Move_Down","Move_Up")

var Look_Vector:Vector2:
	get:return GetVector("Look_Left","Look_Right","Look_Down","Look_Up") + Mouse_Velocity
	
	
var Mouse_Position: Vector2:
	get: return  get_viewport().get_mouse_position()
	
	
var last_mouse_position:Vector2 = Vector2.ZERO
var Mouse_Velocity: Vector2 = Vector2.ZERO
var Mouse_Sensitivity: float = 4
var Lock_Mouse:bool = true


func _ready() -> void:
	last_mouse_position = Mouse_Position
	Lock_Mouse = true
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
func _physics_process(delta: float) -> void:
	_update_mouse_velocity()

	if (Input.is_action_just_pressed("Escape")):
		Lock_Mouse = !Lock_Mouse
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if !Lock_Mouse else Input.MOUSE_MODE_HIDDEN)

func _update_mouse_velocity() -> void:
	Mouse_Velocity = (Mouse_Position - last_mouse_position) * Mouse_Sensitivity
	Mouse_Velocity.y *= -1
	if(Lock_Mouse):
		Input.warp_mouse(get_viewport().size * 0.5)
	last_mouse_position = Mouse_Position

static func GetVector(hor_neg:String,hor_pos:String,ver_neg:String,ver_pos:String) -> Vector2:
	var hor = Input.get_axis(hor_pos,hor_neg)
	var ver = Input.get_axis(ver_pos,ver_neg)
	return Vector2(hor,ver).limit_length(1)
