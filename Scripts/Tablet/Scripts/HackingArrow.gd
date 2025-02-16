class_name HackingArrow
extends Area2D

@export var sm:StateMachine
@export var aim_state:State

var current_cash:int
signal level_completed

func enter_end_node(node:HackingEnd):
	if(sm.active_state == aim_state):
		return
	aim_state.position = node.global_position
	sm.Change_State(aim_state)
	level_completed.emit()

func enter_hacking_node(_node:HackingNode):
	if(sm.active_state == aim_state):
		return
	current_cash += _node.reward
	_node.reward = 0
	aim_state.position = _node.global_position
	sm.Change_State(aim_state)
	
func enter_firewall(_firewall:Firewall):
	if(sm.active_state == aim_state):
		return
	sm.Change_State(aim_state)

func exit_border(_border:HackingBorder):
	if(sm.active_state == aim_state):
		return
	sm.Change_State(aim_state)
