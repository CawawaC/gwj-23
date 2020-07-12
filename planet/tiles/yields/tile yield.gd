extends Spatial

class_name TileYield

export (int) var food
export (int) var industry

export (PackedScene) var food_icon
export (PackedScene) var industry_icon

func init():
	update_icons()
	layout()

func layout():
	var count = get_child_count()
	for i in range(0, count):
		var c = get_child(i)
#		c.translation = Vector3(0.001*i, 0, 0)
		var s = 0.005
		c.translation = Vector3(s*i, 0, 0) - Vector3(s*count/2, 0, 0)
		printt("trans ", c.translation)

func set_values(tile_yield):
	food = tile_yield.food
	industry = tile_yield.industry
	
	remove_icons()
	update_icons()
	
	layout()

func remove_icons():
	for c in get_children():
		c.queue_free()

func update_icons():
	instance_icons(food, food_icon)
	instance_icons(industry, industry_icon)

func instance_icons(num, template):
	for i in range(0, num):
		var instance = template.instance()
		add_child(instance)
