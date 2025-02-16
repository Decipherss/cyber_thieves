class_name StateMachine extends Node

@export var First_State:State

var active_state:State = null
var last_active_state:State = null

var states_dict:Dictionary = {}

func _ready() -> void:
	_get_states()	
	if(!Change_State(First_State) && states_dict.values()[0] != null):
		Change_State(states_dict.values()[0]) 

func _process(_delta: float) -> void:
	if(active_state == null):
		return
	active_state.On_Update(self,_delta)
	
func _physics_process(_delta: float) -> void:
	if(active_state == null):
		return
	active_state.On_Physic_Update(self,_delta)
	
func _get_states() -> void:
	states_dict.clear()	
	for child in get_children():
		if(child is not State):
			continue			
		states_dict[child.name] = child

func Change_State_From_Name(state_name:String,_allow_transition_to_self:bool = false) -> bool:
		return Change_State(states_dict[state_name])

func Change_State(state:State,allow_transition_to_self:bool = false) -> bool:
	if(state == null):
		return false
	elif(state == active_state and !allow_transition_to_self):
		return false
	
	if(active_state):
		active_state.On_Exit(self)
		last_active_state = active_state
		
	active_state = state
	active_state.On_Enter(self)
	return true
	
