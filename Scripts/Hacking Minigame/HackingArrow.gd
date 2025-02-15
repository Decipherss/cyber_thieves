class_name HackingArrow
extends Area2D

@export var sm:StateMachine
@export var aim_state:State

func enter_hacking_node(node:HackingNode):
	#get reward node.reward
	aim_state.position = node.global_position
	sm.Change_State(aim_state)
	pass
	
func enter_firewall(firewall:Firewall):
	#get reward node.reward
	sm.Change_State(aim_state)
	pass
