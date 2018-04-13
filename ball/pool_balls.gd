extends Spatial

const center = 4
const corner1 = 14
const corner2 = 10

var slots = []

func _ready():
	for ball in $Balls.get_children():
		slots.push_back(ball)
	shuffle()
	fix()

func _process(delta):
	pass

func shuffle():
	var shuffles = randi() % 7000 + 500
	while shuffles >= 0:
		var ball1 = randi() % slots.size()
		var ball2 = randi() % slots.size()
		
		swap_balls(ball1, ball2)
		shuffles -= 1

func fix():
	swap_balls(get_ball_idx(Game.ball_class.BALL_8), center)
	
	var i = 0
	for ball in slots:
		if ball.type < Game.ball_class.BALL_8:
			swap_balls(i, corner1)
			break
		i += 1
	
	i = 0
	for ball in slots:
		if ball.type > Game.ball_class.BALL_8:
			swap_balls(i, corner2)
			break
		i += 1
	

func swap_balls(idx_1, idx_2):
	var ball1 = slots[idx_1]
	var ball2 = slots[idx_2]
	
	var temp = ball1.translation
	ball1.translation = ball2.translation
	ball2.translation = temp
	
	slots[idx_1] = ball2
	slots[idx_2] = ball1

func get_ball(type):
	for ball in slots:
		if ball.type == type:
			return ball

func get_ball_idx(type):
	var i = 0
	for ball in slots:
		if ball.type == type:
			return i
		i += 1