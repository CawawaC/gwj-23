extends MeshInstance

export (float, -1, 1) var altitude setget set_altitude

var area
var selected_material

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

func unselect():
	material_override = null

func set_altitude(value):
	altitude = value
	var alt_col = Color(0, 0, altitude)
	
	var mat = get_surface_material(0)
#	var alt_col = Color(0, 0, altitude)
	mat.albedo_color = alt_col
	set_surface_material(0, mat)
