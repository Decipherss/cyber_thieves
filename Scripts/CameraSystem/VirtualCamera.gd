@tool
class_name VirtualCamera extends Node3D

static var Virtual_Cameras: Dictionary = {}
static var Current_Active: VirtualCamera = null

@export_range(1,179) var FOV:float = 75
@export_range(0.0001,10) var Near_Plane:float = 0.05
@export_range(10,10000) var Far_Plane:float = 4000
@export var Priority: int = 0:
	set(value):
		Priority = value
		_on_priority_changed()
		
var Position:Vector3:
	get:return global_position
var Rotation:Vector3:
	get:return global_rotation
var Rotation_Degrees:Vector3:
	get:return global_rotation_degrees
var Forward:Vector3:
	get: return -global_transform.basis.z	
var Right:Vector3:
	get: return global_transform.basis.x
var Up:Vector3:
	get: return global_transform.basis.y

var _init_fov

func _ready() -> void:
	_init_fov = FOV
	_on_tree_entered()
			
func _process(delta: float) -> void:
	if(!Engine.is_editor_hint()):
		return
	_draw_frostrum(delta)

func _get_virtual_camera_highest_priority() -> VirtualCamera:
	if Virtual_Cameras.is_empty():
		return null
	
	var cameras: Array = Virtual_Cameras.keys()
	cameras.sort_custom(func(a, b): return a.Priority > b.Priority)
	
	return cameras[0] if cameras.size() > 0 else null

func _on_priority_changed() -> void:
	Current_Active = _get_virtual_camera_highest_priority()

func _on_tree_entered() -> void:
	Virtual_Cameras[self] = self
	Current_Active = _get_virtual_camera_highest_priority()

func _on_tree_exiting() -> void:
	Virtual_Cameras.erase(self)
	if Current_Active == self:
		Current_Active = _get_virtual_camera_highest_priority()

func _on_visibility_changed() -> void:
	if (visible):
		_on_tree_entered()
	else:
		_on_tree_exiting() 

func _draw_frostrum(duration: float)->void:
	 # Berechne das Frustum
	var color = Color(1,0,0,1)
	var far = lerp(1.0,0.0,inverse_lerp(0,180,FOV))
	var aspect_ratio = get_viewport().size.x / float(get_viewport().size.y)
	var far_height = tan(deg_to_rad(FOV) / 2) * far
	var far_width = far_height * aspect_ratio
	var far_center = Position + Forward * far

	var far_tl = far_center + (Up * far_height) - (Right * far_width)
	var far_tr = far_center + (Up * far_height) + (Right * far_width)
	var far_bl = far_center - (Up * far_height) - (Right * far_width)
	var far_br = far_center - (Up * far_height) + (Right * far_width)
	
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()

	get_tree().root.add_child(mesh_instance)
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF

	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	# frostrum
	immediate_mesh.surface_add_vertex(Position)
	immediate_mesh.surface_add_vertex(far_tl)
	immediate_mesh.surface_add_vertex(Position)
	immediate_mesh.surface_add_vertex(far_tr)
	immediate_mesh.surface_add_vertex(Position)
	immediate_mesh.surface_add_vertex(far_bl)
	immediate_mesh.surface_add_vertex(Position)
	immediate_mesh.surface_add_vertex(far_br)
	# plane
	immediate_mesh.surface_add_vertex(far_tl)
	immediate_mesh.surface_add_vertex(far_tr)
	immediate_mesh.surface_add_vertex(far_tr)
	immediate_mesh.surface_add_vertex(far_br)
	immediate_mesh.surface_add_vertex(far_br)
	immediate_mesh.surface_add_vertex(far_bl)
	immediate_mesh.surface_add_vertex(far_bl)
	immediate_mesh.surface_add_vertex(far_tl)
	
	# Arrow
	immediate_mesh.surface_add_vertex(lerp(far_tl,far_tr,0.4))
	immediate_mesh.surface_add_vertex(lerp(far_tl,far_tr,0.5) + Up * 0.25)
	immediate_mesh.surface_add_vertex(lerp(far_tl,far_tr,0.6))
	immediate_mesh.surface_add_vertex(lerp(far_tl,far_tr,0.5) + Up * 0.25)
	
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = color
	
	await get_tree().create_timer(duration).timeout
	mesh_instance.queue_free()		
