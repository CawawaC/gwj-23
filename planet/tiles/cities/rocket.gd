extends Spatial

class_name Rocket

enum State { Building, Built }

export (float) var building_speed = 1
export (float) var capacity = 1.0 # millions

var built_ratio := 0.0
var city
var state

func _ready():
	state = State.Building

func init(c):
	city = c

func _process(delta):
	built_ratio += delta * building_speed
	if built_ratio >= 1.0:
		built_ratio = 1.0
		state = State.Built
#		city.emit_signal("rocket_built")

func launch():
	Player.population_saved += capacity
	city.population -= capacity
	queue_free()
