extends Spatial

onready var tiles = $trunci/tiles
onready var ui = $ui
onready var defeat = $ui/ui/defeat

func _ready():
	for t in tiles.get_children():
		t.connect("city_selected", ui, "on_city_selected")
		t.connect("biome_changed", self, "on_biome_changed")

func on_biome_changed(tile):
	if tiles.cities_count == 0:
		game_over()

func game_over():
	defeat.show()
	Time.stop()
