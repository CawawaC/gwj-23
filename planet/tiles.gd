extends Spatial

func tiles_count(biome):
	var c = 0
	for t in get_children():
		if t.biome == biome:
			c += 1
	return c
