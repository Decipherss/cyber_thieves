class_name HackingTimer
extends Node2D

@onready var timer: Timer = $Timer
@onready var time_left_display: RichTextLabel = $"Time Left Display"

signal on_timer_ended

func _ready():
	timer.timeout.connect(call_timeout_signal)

func _physics_process(_delta: float) -> void:
	if timer.is_stopped():
		return
	_update_display()

func _update_display():
	time_left_display.text = format_time(timer.time_left)

func start_timer(sec: int):
	timer.wait_time = sec
	timer.start()
	_update_display()

func call_timeout_signal() -> void:
	on_timer_ended.emit()
	time_left_display.text = ""

func format_time(seconds: float) -> String:
	var minutes = roundi(int(seconds) / 60)
	var secs = roundi(int(seconds) % 60)
	return "%02d:%02d" % [minutes, secs]

	
