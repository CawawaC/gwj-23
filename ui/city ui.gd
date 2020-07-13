extends Control

onready var food_num = $resources/food/num
onready var indu_num = $resources/industry/num
onready var pop_num = $resources/population/num
onready var rocket_progress = $construction/rocket/progress

var selected_tile

func _ready():
	close()

func init(tile):
	selected_tile = tile
	
	var city_yield = tile.city.total_yield
	food_num.text = String(city_yield.food)
	indu_num.text = String(city_yield.industry)

func _process(delta):
	if selected_tile:
		update_pop()
	
		if selected_tile.city.rocket:
			rocket_progress.value = selected_tile.city.rocket.built_ratio * 100
			
#			if rocket.

func update_pop():
	var pop = selected_tile.city.population
	var millions = int(pop)
	var thousands = round((pop - millions) * 1000)
	var pop_s = String(millions) + "." + String(thousands)
	pop_num.text = pop_s

func open():
	show()

func close():
	hide()
	selected_tile = null
