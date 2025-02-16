extends State

var npc = null
@onready var scan_text:Node2D = $"Scan Text"
@onready var hacking_state:State = $"../Hacking"
@onready var standby_state:State = $"../Standby"

var completed:bool = false

func On_Enter(_sm)-> bool:
	scan_text.get_node("AnimationPlayer").play("start")
	await get_tree().create_timer(3).timeout
	completed = true
	return true

func On_Exit(_sm)-> bool:
	scan_text.get_node("AnimationPlayer").play("stop")
	completed = false
	return true
	
func On_Update(_sm,_delta) -> bool:	
	if(!completed):
		return true
	
	if(Inputs.Hack):
		hacking_state.difficulty = npc.difficulty
		hacking_state.bank_account = npc.bank_account
		hacking_state.time = npc.time
		return _sm.Change_State(hacking_state)
	
	if(Inputs.Escape):
		return _sm.Change_State(standby_state)
		
	return true
	
func On_Physic_Update(_sm,_delta) -> bool:
	return true
