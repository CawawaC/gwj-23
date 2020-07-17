extends VBoxContainer

onready var population_saved_num = $saved/num
onready var population_dead_num = $lost/num
onready var population_remain_num = $remain/num
onready var tiles = $"../../../trunci/tiles"

var dec = 2

func _process(delta):
	population_saved_num.text = String(Player.population_saved).pad_decimals(dec)
	population_dead_num.text = String(Player.population_dead).pad_decimals(dec)
	var pop = tiles.get_population_count()
	population_remain_num.text = String(pop).pad_decimals(dec)
