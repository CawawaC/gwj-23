extends Spatial

onready var tiles = $trunci/tiles
onready var ui = $ui
onready var defeat = $ui/ui/defeat

func _ready():
	for t in tiles.get_children():
		t.connect("city_selected", ui, "on_city_selected")
		t.connect("biome_changed", self, "on_biome_changed")

func _process(delta):
	if tiles.get_cities_count() <= 0:
		game_over()
	
	var pop = tiles.get_population_count() 
	if pop <= 0.01:
		game_over()

func on_biome_changed(tile):
	if tiles.cities_count == 0:
		game_over()

func game_over():
	defeat.show()
	$ui/ui/defeat/center/vbox/lost/num.text = String(Player.population_dead).pad_decimals(3)
	$ui/ui/defeat/center/vbox/saved/num.text = String(Player.population_saved).pad_decimals(3)
	
	Time.stop()
