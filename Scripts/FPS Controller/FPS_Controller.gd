class_name FPS_Controller
extends CharacterBody3D

@export var camera:Node3D 

var Smooth_Velocity:Vector3
var Smooth_Velocity_XY:Vector2:
	get: return Vector2(Smooth_Velocity.x,Smooth_Velocity.y)
	
var Smooth_Velocity_XZ:Vector2:
	get: return Vector2(Smooth_Velocity.x,Smooth_Velocity.z)
func Look(input:Vector2,clampY:float,delta:float) -> void:
	camera.rotation_degrees.y -= input.x * delta
	camera.rotation_degrees.x += input.y * delta
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x,-abs(clampY),abs(clampY))
	
func Jump(force:float) -> void:
	if(not is_on_floor()):
		return
	velocity.y += abs(force)
	
func ApplyGravity(gravity:float,delta:float) -> void:
	velocity.y -= abs(gravity) * delta

func Move(input:Vector2,speed:float,delta:float):
	var right = (-camera.global_basis.x * Vector3(1,0,1)).normalized() * input.x
	var forward = (camera.global_basis.z * Vector3(1,0,1)).normalized() * input.y
	var input_velocity = (right+forward).limit_length(1) * speed
	velocity.x = input_velocity.x * speed * delta
	velocity.z = input_velocity.z * speed * delta
	

func _physics_process(_delta: float) -> void:
	Smooth_Velocity += (velocity - Smooth_Velocity) * _delta * 5
	move_and_slide()
	
