extends Node

var start_time
var time_scale = 1
#var time_scale = 1000

var pause = false

func _ready():
	start()

func start():
	pause = false
	start_time = OS.get_ticks_msec()

func stop():
	pause = true

func get_time():
	return OS.get_ticks_msec() - start_time
