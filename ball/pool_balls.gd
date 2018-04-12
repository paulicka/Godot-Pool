extends Spatial

const center = 4
const corner1 = 14
const corner2 = 10

var slots = []

func _ready():
	for ball in get_children():
		slots.push_back(ball)
	shuffle()
	fix()

func _process(delta):
	pass

func shuffle():
	var shuffles = randi() % 2048 + 50
	while shuffles >= 0:
		var ball1 = randi() % slots.size()
		var ball2 = randi() % slots.size()
		
		swap_balls(ball1, ball2)
		shuffles -= 1

func fix():
	swap_balls(get_ball_idx(Game.ball_class.BALL_8), slots[center].get_index())
	for ball in slots:
		if ball.type < Game.ball_class.BALL_8:
			swap_balls(ball.get_index(), slots[corner1].get_index())
			break
	
	for ball in slots:
		if ball.type > Game.ball_class.BALL_8:
			swap_balls(ball.get_index(), slots[corner2].get_index())
			break
	

func swap_balls(idx_1, idx_2):
	var ball1 = slots[idx_1]
	var ball2 = slots[idx_2]
	
	var temp = ball1.translation
	ball1.translation = ball2.translation
	ball2.translation = temp
	
	var temp_ball = slots[idx_1]
	slots[idx_1] = slots[idx_2]
	slots[idx_2] = temp_ball

func get_ball(type):
	for ball in slots:
		if ball.type == type:
			return ball

func get_ball_idx(type):
	return get_ball(type).get_index()