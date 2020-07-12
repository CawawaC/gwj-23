extends Spatial

onready var noise = OpenSimplexNoise.new()
onready var tiles = $"../tiles"

func generate():
	randomize()
	noise.seed = randi()
	noise.period = 4
	noise.octaves = 2
	
	for tile in tiles.get_children():
		var mdt = MeshDataTool.new()
		mdt.create_from_surface(tile.mesh, 0)
		var normal = mdt.get_face_normal(0)
		var noise_data = noise.get_noise_3d(normal.x, normal.y, normal.z)
		tile.altitude = (noise_data + 1)/2
	
	Planet.water_level = 0.2
