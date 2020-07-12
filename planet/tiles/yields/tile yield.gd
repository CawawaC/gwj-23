extends Spatial

class_name TileYield

export (int) var food
export (int) var industry

func init():
	print("heee")
	layout()

func layout():
	var count = get_child_count()
	for i in range(0, count):
		var c = get_child(i)
#		c.translation = Vector3(0.001*i, 0, 0)
		var s = 0.005
		c.translation = Vector3(s*i, 0, 0) - Vector3(s*count/2, 0, 0)
		printt("trans ", c.translation)
