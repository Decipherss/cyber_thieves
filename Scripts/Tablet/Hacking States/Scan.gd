extends State

var npc:NPC = null
@onready var scan_text:Node2D = $"Info/Scan Text"
@onready var hacking_state:State = $"../Hacking"
@onready var standby_state:State = $"../Standby"

@onready var info_parent:Node2D = $Info
@onready var difficulty_meter:HackingMeter = $"Info/Difficulty Meter"
@onready var bank_account_meter:HackingMeter = $"Info/Bank Account Meter"
@onready var time_display:RichTextLabel = $Info/Time


var puffer_difficulty:int 
var puffer_bank_account:int 
var puffer_time:int 

var completed:bool = false

func On_Enter(_sm)-> bool:
	info_parent.show()
	puffer_difficulty = npc.difficulty
	puffer_bank_account = npc.bankaccount
	puffer_time = npc.time
	scan_text.get_node("AnimationPlayer").play("start")
	await get_tree().create_timer(3).timeout
	difficulty_meter.set_meter(puffer_difficulty)
	bank_account_meter.set_meter(puffer_bank_account)
	time_display.text = str(puffer_time) + " s"
	completed = true
	return true

func On_Exit(_sm)-> bool:
	scan_text.get_node("AnimationPlayer").play("stop")
	info_parent.hide()
	completed = false
	
	return true
	
func On_Update(_sm,_delta) -> bool:	
	if(!completed):
		return true
	
	if(Inputs.Hack):
		hacking_state.difficulty = puffer_difficulty
		hacking_state.bank_account = puffer_bank_account
		hacking_state.time = puffer_time
		return _sm.Change_State(hacking_state)
	
	if(Inputs.Escape):
		return _sm.Change_State(standby_state)
		
	return true
	
func On_Physic_Update(_sm,_delta) -> bool:
	return true
