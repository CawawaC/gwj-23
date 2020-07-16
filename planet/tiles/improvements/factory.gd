extends Spatial

enum Improvement { Mine, Farm, Polder }

func get_improvement(improvement):
	match improvement:
		Improvement.Mine: return $mine
