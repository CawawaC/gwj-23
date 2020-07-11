extends Spatial

onready var tiles = $tiles

export (PackedScene) var clickable_area_template
export (Material) var selected_material

func _ready():
	for face in tiles.get_children():
		face.selected_material = selected_material
		
		var clickable_area_instance = clickable_area_template.instance()
		face.add_child(clickable_area_instance)
		
		var mdt = MeshDataTool.new()
		mdt.create_from_surface(face.mesh, 0)
		
		var vertices = []
		for i in range(0, mdt.get_vertex_count()):
			vertices.append(mdt.get_vertex(i))
		
		var collision_shape = clickable_area_instance.get_node("collision shape")
		collision_shape.shape = ConvexPolygonShape.new()
		collision_shape.shape.points = vertices
		face.init()
		
		face.connect("unselect_tiles", self, "unselect_tiles")

func unselect_tiles():
	for face in tiles.get_children():
		face.unselect()
