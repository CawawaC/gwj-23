extends Area

signal tile_clicked

func area_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			emit_signal("tile_clicked")
