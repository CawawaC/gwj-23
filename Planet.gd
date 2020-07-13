extends Node

enum Biome { Ocean, Ground, Pole } 

#var biome_yields = {
#	Biome.Ocean: TileYield.new(1, 1),
#	Biome.Ground: TileYield.new(2, 1)
#}

var water_level # 0 to 1
var water_rise_speed = 0.0001 # water level per second
#var water_rise_speed = 0.1 # debug

var north_pole
var south_pole
var axis # unitary vector, points from center to north pole

var desired_ocean_tiles_at_start = 9

func _process(delta):
	if water_level != null and not Time.pause:
		water_level += delta * water_rise_speed * Time.time_scale

func get_tile_yield(biome):
	match biome:
		Biome.Ocean:
			return $ocean
		Biome.Ground:
			return $ground
	
	return $default
