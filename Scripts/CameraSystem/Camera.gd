class_name Camera extends Camera3D

static var _main: Camera = null 

var Main: Camera:
	get: return _main  

func _ready() -> void:
	if _main == null:
		_main = self

func _process(_delta: float) -> void:
	var active: VirtualCamera = VirtualCamera.Current_Active
	if active:
		_update_camera(active)


func _update_camera(camera: VirtualCamera) -> void:
	position = camera.Position
	rotation = camera.Rotation
	fov = camera.FOV
	near = camera.Near_Plane
	far = camera.Far_Plane
	
	
