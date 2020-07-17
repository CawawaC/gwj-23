extends Spatial

export (SpatialMaterial) var influence_outline_material

onready var rocket = $rocket
onready var total_yield = $yield setget , get_total_yield

var tile
var population:float # millions
var min_pop = 10 # millions
var max_pop = 30 # millions
var influenced_tiles:Array

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
	influenced_tiles = tile.adjacent_tiles.duplicate()
	influenced_tiles.append(tile)

func paint_influence():
	paint_influence_on_tiles(influenced_tiles)

func paint_influence_on_tiles(ts):
	for i in ts:
		var tile_mat = i.get_surface_material(0) as SpatialMaterial
		tile_mat.next_pass = influence_outline_material
		i.set_surface_material(0, tile_mat)

func erase_influence():
	for i in influenced_tiles:
		var tile_mat = i.get_surface_material(0) as SpatialMaterial
		tile_mat.next_pass = null
		i.set_surface_material(0, tile_mat)

func build_improvement(tile, improvement):
	tile.build_improvement(improvement.duplicate())

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
