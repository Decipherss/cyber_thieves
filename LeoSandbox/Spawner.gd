extends Node3D

@export var npc_scene: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_npc()
	$Timer.timeout.connect(spawn_npc)

func spawn_npc():
	if npc_scene:
		var npc = npc_scene.instantiate()
		add_child(npc)
		npc.global_transform = global_transform
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
