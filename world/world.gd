extends Node

var table

func _ready():
	Game.world = self
	

func _process(delta):
	pass

func get_camera():
	return $Camera