extends Spatial

var cities_count setget , get_cities_count

func tiles_count(biome):
	var c = 0
	for t in get_children():
		if t.biome == biome:
			c += 1
	return c

func find_adjacents():
	for t in get_children():
		t.adjacent_tiles = []
		
		# get the tile's normal vector
		var mdt = MeshDataTool.new()
		mdt.create_from_surface(t.mesh, 0)
		var t_normal = mdt.get_face_normal(0)
		
		# look at all other tiles and compare their normals to the tile's
		var angles = {}
		var mdt2 = MeshDataTool.new()
		for t2 in get_children():
			if t != t2:
				mdt2.create_from_surface(t2.mesh, 0)
				var t2_normal = mdt2.get_face_normal(0)
				
				# get the angle between the two normals
				var phi = acos(t_normal.dot(t2_normal))
				angles[phi] = t2
		
		# sort the angles
		var sorted_angles = angles.keys()
		sorted_angles.sort()
		
		# pick smallest angles: they correspond to the closest tiles
		# number of adjacent tiles is the number of sides of the tile
		# pick as many smallest angles
		for i in range(0, t.sides_count):
			var adjacent = angles[sorted_angles[i]]
			t.adjacent_tiles.append(adjacent)


func get_opposite(tile):
	var normal = tile.get_face_normal()
	
	var oppo
	for t2 in get_children():
		var mdt2 = MeshDataTool.new()
		mdt2.create_from_surface(t2.mesh, 0)
		var n2 = mdt2.get_face_normal(0)
		
		var dot = n2.dot(normal)
		if dot < -0.99:
			oppo = t2
			break
	
	return oppo

func get_cities_count():
	var sum = 0
	for t in get_children():
		if t.city: sum += 1
	return sum
