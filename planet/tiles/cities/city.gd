extends Spatial

onready var rocket = $rocket
onready var total_yield = $yield setget , get_total_yield

var tile
var population:float # millions
var min_pop = 10 # millions
var max_pop = 30 # millions
signal city_destroyed

signal rocket_progress


func _ready():
	population = rand_range(min_pop, max_pop)
	rocket.init(self)

func _process(delta):
	if rocket:
		emit_signal("rocket_progress", rocket.built_ratio)

func init(t):
	tile = t

func destroy():
	Player.population_dead += population
	population = 0
	queue_free()

func get_total_yield():
	total_yield = $yield
	total_yield.food = tile.tile_yield.food
	total_yield.industry = tile.tile_yield.industry
	for t in tile.adjacent_tiles:
		total_yield.food += t.tile_yield.food
		total_yield.industry += t.tile_yield.industry
	return total_yield
