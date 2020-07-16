extends Spatial

class_name Rocket

enum State { Building, Built }

export (float) var building_speed = 0.01
export (float) var capacity = 1.0 # millions
export (int) var required_production = 5


var built_ratio := 0.0
var build_start_time
var city
var state

func _ready():
	state = State.Building

func init(c):
	city = c
	build_start_time = Time.get_time()

func _process(delta):
	built_ratio = (Time.get_time() - build_start_time) * building_speed
	if built_ratio >= 1.0:
		built_ratio = 1.0
		state = State.Built
#		city.emit_signal("rocket_built")

func launch():
	Player.population_saved += capacity
	city.population -= capacity
	queue_free()
