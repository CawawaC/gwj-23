extends Spatial

onready var tiles = $tiles

export (PackedScene) var clickable_area_template
export (Material) var selected_material
export (PackedScene) var tile_yield_template


func _ready():
	for face in tiles.get_children():
		face.selected_material = selected_material
		
		var clickable_area_instance = clickable_area_template.instance()
		face.add_child(clickable_area_instance)
		
		var tile_yield = tile_yield_template.instance()
		face.add_child(tile_yield)
		
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
		
	$generator.generate()

func unselect_tiles():
	for face in tiles.get_children():
		face.unselect()

func _input(event):
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(BUTTON_LEFT):
		if event.relative != Vector2.ZERO:
			var rot = Vector3(event.relative.y, event.relative.x, 1)
			rot = rot.normalized()
			rotate(rot, event.speed.length()/10000)
