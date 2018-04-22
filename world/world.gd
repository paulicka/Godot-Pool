extends Node

var table
var cursor_pos = Vector2()

func _ready():
	Game.world = self

func _process(delta):
	pass

func _physics_process(delta):
	var pos = $Camera.project_ray(get_viewport().get_mouse_position())
	if pos != null:
		cursor_pos.x = pos.x
		cursor_pos.y = pos.z

func get_camera():
	return $Camera

func get_cue_ball():
	return $Ball

func get_cue():
	return $Cue

func get_cursor_pos():
	return cursor_pos