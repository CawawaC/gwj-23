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
		
	$tiles.find_adjacents()
	$generator.generate()
	

func unselect_tiles():
	for face in tiles.get_children():
		face.unselect()

func _input(event):
	if event is InputEventMouseMotion:
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			if event.relative != Vector2.ZERO:
				var rot = Vector3(1, event.relative.x, -event.relative.y)
				rot = rot.normalized()
				rotate(rot, event.speed.length()/10000)
	elif event is InputEventMouseButton and event.is_pressed():
		var trans = 1
		var pos = $"../camera".translation
		if event.button_index == BUTTON_WHEEL_UP:
			# zoom in
			if pos.x > 25:
				$"../camera".translation.x = 25
			else: 
				$"../camera".translate_object_local(Vector3(0, 0, trans))
			
		elif event.button_index == BUTTON_WHEEL_DOWN:
			# zoom in
			if pos.x < 5:
				$"../camera".translation.x = 5
			else:
				$"../camera".translate_object_local(Vector3(0, 0, -trans))
		print($"../camera".translation)
