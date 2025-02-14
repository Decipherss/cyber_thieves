extends AudioStreamPlayer3D

@export var footsteps:SoundCollection

var rnd:RandomNumberGenerator

func _ready() -> void:
	rnd = RandomNumberGenerator.new()
		
func get_random_by_name(meta:String) -> AudioStream:
	# no sounds
	if(footsteps == null || footsteps.collection.size() == 0 || !footsteps.collection.has(meta)):
		return AudioStream.new()

	var size:int = footsteps.collection[meta].size() -1
	return footsteps.collection[meta][rnd.randi_range(0,size)]

func play_footstep_sfx() -> void:	
	var start = global_position + Vector3.UP  * 0.1
	var end = global_position + Vector3.DOWN *  5
	var space = get_tree().root.world_3d.direct_space_state
	var query = PhysicsRayQueryParameters3D.create(start,end)
	query.hit_from_inside = false
	query.collide_with_areas = false
	query.hit_back_faces = false
	var hit = space.intersect_ray(query)
	
	if(hit.is_empty() || !hit["collider"].has_meta("surface")):
		return
	
	var meta:String = hit["collider"].get_meta("surface")
	stream = get_random_by_name(meta)
	play()
	
	
	
