extends Spatial

export (float) var building_speed = 0.01
export (float) var capacity = 1.0 # millions

var built_ratio := 0.0
var city

func _ready():
	pass

func init(c):
	city = c

func _process(delta):
	built_ratio += delta * building_speed
	if built_ratio >= 1.0:
		built_ratio = 1.0
#		city.emit_signal("rocket_built")
		launch()

func launch():
	Player.population_saved += capacity
	city.population -= capacity
	queue_free()
