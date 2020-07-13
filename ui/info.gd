extends VBoxContainer

onready var population_saved_num = $saved/num
onready var population_dead_num = $lost/num

func _process(delta):
	population_saved_num.text = String(Player.population_saved).pad_decimals(3)
	population_dead_num.text = String(Player.population_dead).pad_decimals(3)
