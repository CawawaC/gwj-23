extends MeshInstance

var elevation_threshold = 0.5

func can_build(tile):
	return tile.altitude >= elevation_threshold
