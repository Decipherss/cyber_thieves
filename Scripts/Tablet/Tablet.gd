class_name Tablet
extends Node

@onready var sm:StateMachine = $"State Machine"

@onready var hacking_state:State = $"State Machine/Hacking"
@onready var scan_state:State = $"State Machine/Scan"
@onready var cash_display:RichTextLabel = $Cash

var cash:int = 0

func _ready() -> void:
	start_scan(1)
	
func start_scan(npc):
	scan_state.npc = npc
	sm.Change_State(scan_state)

func start_hacking(difficulty:int,bank_account:int,time:int):
	hacking_state.difficulty = difficulty
	hacking_state.bank_account = bank_account
	hacking_state.time = time
	sm.Change_State(hacking_state)
	
	
func Add_Cash(cash:int):
	self.cash += cash
	cash_display.text = "Cash: "+str(self.cash)
