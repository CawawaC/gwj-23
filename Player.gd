extends Node

var population_saved
var population_dead

func _ready():
	init()

func init():
	population_saved = 0
	population_dead = 0
