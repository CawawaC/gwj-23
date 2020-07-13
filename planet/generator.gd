extends Spatial

export (PackedScene) var city_template

onready var noise = OpenSimplexNoise.new()
onready var tiles = $"../tiles"

func generate():
	randomize()
	noise.seed = randi()
	noise.octaves = 2
	noise.period = 58
	noise.persistence = 0.3
	noise.lacunarity = 2.1
	
	
	for tile in tiles.get_children():
		var mdt = MeshDataTool.new()
		mdt.create_from_surface(tile.mesh, 0)
		var normal = mdt.get_face_normal(0) * 1000
		var noise_data = noise.get_noise_3d(normal.x, normal.y, normal.z)
		tile.altitude = (noise_data + 1)/2
	
	Planet.water_level = 0.45
	
	
	for tile in tiles.get_children():
		tile.determine_biome()
	
	place_cities()
	
	water_level_adjust()
	

func place_cities():
	var cities_to_place = 3
	var city_tiles_i = []
	for i in range(0, cities_to_place):
		var rand = randi() % tiles.get_child_count()
		while city_tiles_i.has(rand) or tiles.get_child(rand).biome == Planet.Biome.Ocean:
			rand = randi() % tiles.get_child_count()
		
		city_tiles_i.append(rand)
	
	for i in city_tiles_i:
		var city = city_template.instance()
		var tile = tiles.get_child(i)
		tile.add_child(city)
		tile.init_city()

func water_level_adjust():
	while tiles.tiles_count(Planet.Biome.Ocean) > Planet.desired_ocean_tiles_at_start:
		Planet.water_level -= 0.01
		for tile in tiles.get_children():
			tile.determine_biome()
