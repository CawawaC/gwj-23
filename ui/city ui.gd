extends Control

onready var food_num = $resources/food/label
onready var indu_num = $resources/industry/label

func _ready():
	close()

func init(tile):
	food_num.text = String(tile.tile_yield.food)
	indu_num.text = String(tile.tile_yield.industry)

func open():
	show()

func close():
	hide()
