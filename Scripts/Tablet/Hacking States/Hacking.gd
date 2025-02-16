extends State

var bank_account:int = 1
var difficulty:int = 1
var time:int = 10

@onready var node_parent: Node = $"Nodes Spawned"
@onready var hacking_timer: HackingTimer = $"Hacking Timer"
@onready var begin_hack_anim: Node2D = $"Begin Hack Anim"
@onready var tablet: Tablet = $"../.."

@export_category("Positions")
@export var position_nodes:Array[Node2D]
@export var start_position_node:Node2D
@export var end_position_node:Node2D
@export var timer_position_node:Node2D

@export_category("Scenes")
@export var easy_nodes:Array[PackedScene]
@export var medium_nodes:Array[PackedScene]
@export var hard_nodes:Array[PackedScene]

@export_category("Scenes")
@export var timer: PackedScene
@export var arrow: PackedScene
@export var start: PackedScene 
@export var border: PackedScene 
@export var end: PackedScene


@export_category("States")
@export var Standby_State: State

var exit_level:bool = false
var player:HackingArrow
var random:RandomNumberGenerator

func _ready() -> void:
	random = RandomNumberGenerator.new()
	

func On_Enter(_sm)-> bool:
	begin_hack_anim.get_node("AnimationPlayer").play("start")
	await get_tree().create_timer(2).timeout
	
	_init_hacking_nodes()
	_init_player_nodes()
	return true

func On_Exit(_sm)-> bool:
	_clear_level()
	exit_level = false
	return true
	
func On_Update(_sm,_delta) -> bool:	
	if(exit_level):
		return _sm.Change_State(Standby_State)
	return true
	
func On_Physic_Update(_sm,_delta) -> bool:
	return true

func on_timer_ended():
	exit_level = true
	pass

func on_completed():
	exit_level = true
	tablet.Add_Cash(player.current_cash)
	pass

func _init_player_nodes():
	player = arrow.instantiate() as HackingArrow
	player.global_position = start_position_node.global_position
	node_parent.add_child(player)
	player.level_completed.connect(on_completed)
	
	var start_node :Node2D = start.instantiate() as Node2D
	start_node.global_position = start_position_node.global_position
	node_parent.add_child(start_node)
	
	var end_node :Node2D = end.instantiate() as Node2D
	end_node.global_position = end_position_node.global_position
	node_parent.add_child(end_node)
	
	var border_node:Node2D = border.instantiate() as Node2D
	border_node.global_position = Vector2.ZERO
	node_parent.add_child(border_node)
	
	var timer_node:HackingTimer = timer.instantiate() as HackingTimer
	timer_node.global_position = timer_position_node.global_position
	node_parent.add_child(timer_node)
	timer_node.start_timer(time)
	timer_node.on_timer_ended.connect(on_timer_ended)

func _clear_level():
	for node in node_parent.get_children():
		node.queue_free()
		
func _init_hacking_nodes():
	var min:int = roundi(position_nodes.size() / 4)
	for i in range(position_nodes.size()):
		var spawn_node:bool = random.randf() < difficulty / 6.0

		if(i % min != 0 && !spawn_node):
			continue
	
		var pos_node:Node2D = position_nodes[i]
		var position:Vector2 = pos_node.global_position
		var reward:int = random.randi_range(1 ,pow((bank_account+1) * 5,2))
		
		_spawn_hacking_node(position,reward)
	
		
func _spawn_hacking_node(position:Vector2,reward:int) -> void:
	var inst:Node2D = _get_scene().instantiate() as Node2D
	node_parent.add_child(inst)
	var hacking_node:HackingNode= inst.get_node("HackingNode")
	inst.global_position = position
	hacking_node.reward = reward
	
func _get_scene() -> PackedScene:
	match difficulty:
		1:return easy_nodes[random.randi_range(0,easy_nodes.size()-1)]
		2:return medium_nodes[random.randi_range(0,medium_nodes.size()-1)]
		3:return hard_nodes[random.randi_range(0,hard_nodes.size()-1)]
		_: return easy_nodes[random.randi_range(0,easy_nodes.size()-1)]
