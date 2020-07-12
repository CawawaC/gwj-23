extends MeshInstance

class_name Tile

export (float, -1, 1) var altitude setget set_altitude

var area
var selected_material
var biome

signal unselect_tiles

func _ready():
	var mat = SpatialMaterial.new()
	set_surface_material(0, mat)


func init():
	area = $area
	area.connect("tile_clicked", self, "on_tile_clicked")
	
#	material_override = selected_material.duplicate()

func on_tile_clicked():
	emit_signal("unselect_tiles")
	select()

func select():
	material_override = selected_material
	print(altitude)
	print(biome)

func unselect():
	material_override = null

func determine_biome():
	var mat = get_surface_material(0)
	var alt_col	
	if altitude <= Planet.water_level:
		biome = Planet.Biome.Ocean
		alt_col = Color(0, 0, altitude)	
		mat.albedo_color = alt_col
	else:
		biome = Planet.Biome.Ground
		alt_col = Color(0, altitude, 0)	
		mat.albedo_color = alt_col
		
	set_surface_material(0, mat)

func set_altitude(value):
	altitude = value
	var alt_col = Color(0, 0, altitude)
	
	var mat = get_surface_material(0)
#	var alt_col = Color(0, 0, altitude)
	mat.albedo_color = alt_col
	set_surface_material(0, mat)
