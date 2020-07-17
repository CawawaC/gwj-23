extends MeshInstance

onready var improvement_yield = $yield

var elevation_threshold = 0.5

func can_build(tile):
	if tile.city:
		return false
	if tile.tile_improvement:
		return false
	
	return tile.altitude >= elevation_threshold
