extends Area

func input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(BUTTON_LEFT):
		var rot = Vector3(event.relative.x, event.relative.y, 0)
		get_parent().rotate(rot, 1)
