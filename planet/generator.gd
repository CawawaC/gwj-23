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
	
	generate_poles()
	
	for tile in tiles.get_children():
		tile.determine_biome()
	
	place_cities()
	
	water_level_adjust()
	

func place_cities():
	var cities_to_place = 3
	var city_tiles_i = []
	for i in range(0, cities_to_place):
		var rand = randi() % tiles.get_child_count()
		while city_tiles_i.has(rand) \
		or tiles.get_child(rand).biome == Planet.Biome.Ocean \
		or tiles.get_child(rand).biome == Planet.Biome.Pole:
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


func generate_poles():
	# pick a random tile
	var rand = randi() % tiles.get_child_count()
	var n_pole = tiles.get_child(rand)
	print(n_pole)
	
	# make it a pole
	Planet.north_pole = n_pole
	
	# pick the tile with opposite normal
	var s_pole = tiles.get_opposite(n_pole)
	
	# make it a pole too
	Planet.south_pole = s_pole
	
	# the pole tile's normal is the planet's axis
	Planet.axis = n_pole.get_face_normal()
	
	for t in tiles.get_children():
		var normal = t.get_face_normal()
		
		# the longer a tile normal's projection (dot product) onto the axis is (in abs values)
		# the colder it is
		var projection = abs(normal.dot(Planet.axis))
		t.temperature_ratio = 1-projection
	
