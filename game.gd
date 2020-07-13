extends Spatial

onready var tiles = $trunci/tiles
onready var ui = $ui

func _ready():
	for t in tiles.get_children():
		t.connect("city_selected", ui, "on_city_selected")
