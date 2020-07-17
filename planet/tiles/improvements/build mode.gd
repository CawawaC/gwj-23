extends Button

onready var tiles = $"../../../../../../trunci/tiles"

export (ImprovementsFactory.Improvement) var improvement

func _ready():
	connect("pressed", self, "enter_build_mode")

func enter_build_mode():
	# connect all tiles' tile_clicked event to build
	for tile in tiles.get_children():
		tile.connect("tile_clicked", self, "build")

func build(tile):
	var improvement_scene = ImprovementsFactory.get_improvement(improvement)
	$"../../..".selected_tile.city.build_improvement(tile, improvement_scene)
	exit_build_mode()

func exit_build_mode():
	# remove all tiles' tile_clicked event connection to build
	for tile in tiles.get_children():
		tile.disconnect("tile_clicked", self, "build")
