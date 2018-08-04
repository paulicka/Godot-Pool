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
		cursor_pos = Util.to_vec2(pos)

func get_camera():
	return $Camera

func get_cue_ball():
	return $CueBall

func get_cue():
	return $Cue

func get_cursor_pos():
	return cursor_pos

func get_balls():
	return $PoolBalls.get_balls()

func balls_are_still():
	var balls = $PoolBalls.get_balls()
	balls.push_back($CueBall)
	for ball in balls:
		if not ball.is_still():
			return false
	return true

func force_still():
	var balls = $PoolBalls.get_balls()
	balls.push_back($CueBall)
	for ball in balls:
		ball.force_still()