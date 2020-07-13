extends CanvasLayer

onready var city_ui = $ui/city

func _ready():
	$ui/defeat.hide()

func on_city_selected(tile):
	city_ui.init(tile)
	city_ui.open()
