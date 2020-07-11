extends MeshInstance

var area
var selected_material

signal unselect_tiles

func init():
	area = $area
	area.connect("tile_clicked", self, "on_tile_clicked")

func on_tile_clicked():
	emit_signal("unselect_tiles")
	select()

func select():
	material_override = selected_material

func unselect():
	material_override = null
