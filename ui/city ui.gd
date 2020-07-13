extends Control

onready var food_num = $resources/food/num
onready var indu_num = $resources/industry/num
onready var pop_num = $resources/population/num
onready var rocket_progress = $construction/rocket/progress
onready var launch_button = $construction/rocket/launch

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
	
		var rocket = selected_tile.city.rocket
		if rocket:
			rocket_progress.value = rocket.built_ratio * 100
			
			if rocket.state == Rocket.State.Built:
				launch_button.disabled = false
			else:
				launch_button.disabled = true
		

func update_pop():
	var pop = selected_tile.city.population
	var millions = int(pop)
	var thousands = (pop - millions) * 1000
	var pop_s = String(millions) + "." + String(int(thousands)).pad_zeros(3)
	pop_num.text = pop_s

func open():
	show()

func close():
	hide()
	selected_tile = null

func on_launch_pressed():
	if selected_tile:
		var rocket = selected_tile.city.rocket
		if rocket:
			rocket.launch()
