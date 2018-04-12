extends Node

const player_class = preload("res://player.gd")
const ball_class = preload("res://ball/ball/ball.gd")

enum SCREEN{
	IDLE, LOBBY, GAME, END
}

enum STAGE{
	PLACE, PLAN, PLAY
}

const ball_styles = [
	"default"
]

const table_styles = [
	
]

const cue_styles = [
	
]

signal game_start()
signal new_turn(player)
signal new_stage(mode)

var world = null

func _ready():
	new_player()

func _process(delta):
	pass

func game_in_progress():
	return world != null

func new_player():
	add_child(player_class.new())