extends Node

var current_style = 0

func _ready():
	for ball_name in Ball:
		ball_name = ball_name.to_lower()
		
	pass

func _process(delta):
	pass

func create_triangle():
	var balls = []
	for ball in Ball:
		balls.push_back(create_ball(Ball[ball]))
	var root = Spatial.new()
	

func fix_triangle(balls):
	pass

func create_ball(type):
	pass