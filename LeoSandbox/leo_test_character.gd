extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
@export var speed: float = 3.0
var target_location: Vector3

func _ready() -> void:
	if not nav_agent.velocity_computed.is_connected(_on_navigation_agent_3d_velocity_computed):
		nav_agent.velocity_computed.connect(_on_navigation_agent_3d_velocity_computed)
	
	
	choose_random_despawn_zone()
	nav_agent.avoidance_enabled = false  # Verhindert komische Physikglitches

func _physics_process(delta: float) -> void:
	if nav_agent.is_navigation_finished():
		return

	# NAVIGATION: Korrekte Wegfindung aktivieren
	var next_location = nav_agent.get_next_path_position()
	next_location.y = global_transform.origin.y  # Höhe fixieren!
	var _direction = (next_location - global_transform.origin).normalized()
	velocity = _direction * speed
	move_and_slide()
	
	if _direction.length() > 0.1:
		look_at(global_transform.origin + _direction, Vector3.UP)

	nav_agent.target_position = target_location

func choose_random_despawn_zone():
	var zones = get_tree().get_nodes_in_group("DespawnZone")
	if zones.size() > 0:
		target_location = zones.pick_random().global_transform.origin
		target_location.y = global_transform.origin.y  # Höhe fixieren!
		nav_agent.target_position = target_location
		

func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	safe_velocity.y = 0  # Vertikale Bewegung blockieren!
	velocity = velocity.move_toward(safe_velocity, 0.25)
	move_and_slide()
