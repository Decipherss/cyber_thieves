class_name Tablet
extends Node

@onready var sm:StateMachine = $"SubViewport/State Machine"

@onready var hacking_state:State = $"SubViewport/State Machine/Hacking"
@onready var scan_state:State =$"SubViewport/State Machine/Scan"
@onready var cash_display:RichTextLabel = $SubViewport/Cash

var cash:int = 0

func start_scan(npc):
	scan_state.npc = npc
	sm.Change_State(scan_state)
	
func Add_Cash(cash:int):
	self.cash += cash
	cash_display.text = "Cash: "+str(self.cash)
