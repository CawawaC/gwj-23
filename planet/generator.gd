extends Spatial

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
		print(tile.altitude)
	
	Planet.water_level = 0.45
	
	for tile in tiles.get_children():
		tile.determine_biome()
		
	water_level_adjust()
	

func water_level_adjust():
	while tiles.tiles_count(Planet.Biome.Ocean) > Planet.desired_ocean_tiles_at_start:
		print(tiles.tiles_count(Planet.Biome.Ocean))
		Planet.water_level -= 0.01
		for tile in tiles.get_children():
			tile.determine_biome()
	print(tiles.tiles_count(Planet.Biome.Ocean))
