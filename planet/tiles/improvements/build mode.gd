extends Button

onready var tiles = $"../../../../../../trunci/tiles"

export (ImprovementsFactory.Improvement) var improvement

func _ready():
	connect("pressed", self, "enter_build_mode")

func enter_build_mode():
	# connect all tiles' tile_clicked event to build
	for tile in tiles.get_children():
		tile.connect("tile_clicked", self, "build")
	
	# change city influence highlight to show can_build tiles
	var improvement_model = ImprovementsFactory.get_improvement(improvement)
	var candidates = []
	var city = $"../../..".selected_tile.city
	for t in city.influenced_tiles:
		if improvement_model.can_build(t):
			candidates.append(t)
	city.erase_influence()
	city.paint_influence_on_tiles(candidates)
	

func build(tile):
	var improvement_scene = ImprovementsFactory.get_improvement(improvement)
	if improvement_scene.can_build(tile):
		$"../../..".selected_tile.city.build_improvement(tile, improvement_scene)
		exit_build_mode()

func exit_build_mode():
	# remove all tiles' tile_clicked event connection to build
	for tile in tiles.get_children():
		tile.disconnect("tile_clicked", self, "build")
	$"../../../../..".on_city_selected($"../../..".selected_tile)
