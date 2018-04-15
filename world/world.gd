extends Node

var table

func _ready():
	Game.world = self
	

func _process(delta):
	pass

func get_camera():
	return $Camera

func get_cue_ball():
	pass

func get_cue():
	pass