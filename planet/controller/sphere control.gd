extends Area

func input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(BUTTON_LEFT):
		if event.relative != Vector2.ZERO:
			var rot = Vector3(event.relative.y, event.relative.x, 1)
			rot = rot.normalized()
			print(rot)
			get_parent().rotate(rot, event.speed.length()/10000)

func _input(event):
	print(event)
