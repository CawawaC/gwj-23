extends MeshInstance

class_name Tile

export (float, -1, 1) var altitude setget set_altitude

var area
var selected_material
var biome
var tile_yield
var city
var mdt: MeshDataTool
var adjacent_tiles
var sides_count
var temperature_ratio
var tile_improvement

signal unselect_tiles
signal city_selected
signal biome_changed
signal tile_clicked

func _ready():
	var mat = SpatialMaterial.new()
	set_surface_material(0, mat)
	
	mdt = MeshDataTool.new()
	mdt.create_from_surface(mesh, 0)
	
	sides_count = mdt.get_vertex_count()

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

func init_city():
	city = $city
	city.init(self)
	var model = $city/model
	var up = Vector3.UP # the model's normal
	city.transform.origin = get_face_center() * 1.1
	
	var normal = get_face_normal()
	var axis = up.cross(normal).normalized()
	var theta = acos(up.dot(normal))
	
	city.rotate(axis, theta)
	city.scale = Vector3(1, 1, 1)

func build_improvement(improv):
	tile_improvement = improv
	add_child(tile_improvement)
	
	var up = Vector3.UP # the model's up
	tile_improvement.transform.origin = get_face_center() * 1.1
	
	var normal = get_face_normal()
	var axis = up.cross(normal).normalized()
	var theta = acos(up.dot(normal))
	
	tile_improvement.rotate(axis, theta)
#	tile_improvement.scale = Vector3(1, 1, 1)

func get_face_center():
	var sum = Vector3.ZERO
	for i in range(0, mdt.get_vertex_count()):
		sum += mdt.get_vertex(i)
	
	return sum / mdt.get_vertex_count()

func get_face_normal():
	return mdt.get_face_normal(0)

func on_tile_clicked():
	emit_signal("unselect_tiles")
	emit_signal("tile_clicked", self)
	select()

func select():
	material_override = selected_material
	if city:
		emit_signal("city_selected", self)
		city.paint_influence()
#	for a in adjacent_tiles:
#		a.material_override = selected_material

func unselect():
	material_override = null
	if city:
		city.erase_influence()

func determine_biome():
	var mat = get_surface_material(0)
	var col
	var new_biome
	if temperature_ratio < 0.01:
		new_biome = Planet.Biome.Pole
		col = Color(1, 1, 1)
	elif altitude <= Planet.water_level:
		new_biome = Planet.Biome.Ocean
		if city:
			city.destroy()
		col = Color(.5, .5, 1)
	else:
		new_biome = Planet.Biome.Ground
		col = Color(temperature_ratio, altitude, 0)
	
	if new_biome != biome:
		biome = new_biome
		tile_yield.set_values(Planet.get_tile_yield(biome))
		emit_signal("biome_changed", self)
	
	mat.albedo_color = col
	set_surface_material(0, mat)

func set_altitude(value):
	altitude = value
	var alt_col = Color(0, 0, altitude)
	
	var mat = get_surface_material(0)
#	var alt_col = Color(0, 0, altitude)
	mat.albedo_color = alt_col
	set_surface_material(0, mat)
