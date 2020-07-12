extends Node

var start_time

func _ready():
	start()

func start():
	start_time = OS.get_ticks_msec()

func get_time():
	return OS.get_ticks_msec() - start_time
