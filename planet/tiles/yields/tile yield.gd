extends Spatial

class_name TileYield

export (int) var food setget , get_food
export (int) var industry setget , get_industry

export (PackedScene) var food_icon
export (PackedScene) var industry_icon

var complements = [] # array of other tile yields

func init():
	update_icons()

func layout():
	var count = get_child_count()
	for i in range(0, count):
		var c = get_child(i)
#		c.translation = Vector3(0.001*i, 0, 0)
		var s = 0.005
		c.translation = Vector3(s*i, 0, 0) - Vector3(s*count/2, 0, 0)

func set_values(tile_yield):
	food = tile_yield.food
	industry = tile_yield.industry
	
	remove_icons()
	update_icons()

func remove_icons():
	for c in get_children():
		c.queue_free()

func update_icons():
	remove_icons()
	instance_icons(get_food(), food_icon)
	instance_icons(get_industry(), industry_icon)
	layout()

func instance_icons(num, template):
	for i in range(0, num):
		var instance = template.instance()
		add_child(instance)

func register_complement(comp):
	complements.append(comp)
	update_icons()

func get_food():
	var sum = food
	for c in complements:
		sum += c.food
	return sum

func get_industry():
	var sum = industry
	for c in complements:
		sum += c.industry
	return sum
