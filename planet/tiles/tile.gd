extends MeshInstance

class_name Tile

export (float, -1, 1) var altitude setget set_altitude

var area
var selected_material
var biome
var tile_yield

signal unselect_tiles

func _ready():
	var mat = SpatialMaterial.new()
	set_surface_material(0, mat)

func _process(delta):
	determine_biome()

func init():
	area = $area
	tile_yield = $"tile yield"
	tile_yield.translation = get_face_center() * 1.1
#	if tile_yield.has_method("layout"):
	tile_yield.init()
	
	area.connect("tile_clicked", self, "on_tile_clicked")
	
#	material_override = selected_material.duplicate()

func get_face_center():
	var mdt = MeshDataTool.new()
	mdt.create_from_surface(mesh, 0)
	
	var sum = Vector3.ZERO
	for i in range(0, mdt.get_vertex_count()):
		sum += mdt.get_vertex(i)
	
	return sum / mdt.get_vertex_count()

func on_tile_clicked():
	emit_signal("unselect_tiles")
	select()

func select():
	material_override = selected_material

func unselect():
	material_override = null

func determine_biome():
	var mat = get_surface_material(0)
	var col
	if altitude <= Planet.water_level:
		biome = Planet.Biome.Ocean
		col = Color(.5, .5, 1)
	else:
		biome = Planet.Biome.Ground
		col = Color(0, altitude, 0)
	
	tile_yield = Planet.get_tile_yield(biome)
	mat.albedo_color = col
	set_surface_material(0, mat)

func set_altitude(value):
	altitude = value
	var alt_col = Color(0, 0, altitude)
	
	var mat = get_surface_material(0)
#	var alt_col = Color(0, 0, altitude)
	mat.albedo_color = alt_col
	set_surface_material(0, mat)
