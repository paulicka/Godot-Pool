extends Node

const player_class = preload("res://player.gd")
const ball_class = preload("res://ball/ball/ball.gd")



enum Screen{
	IDLE, LOBBY, LOADING, GAME, END
}
signal new_screen(screen)
var screen = Screen.GAME setget set_screen
func set_screen(new_screen):
	screen = new_screen
	emit_signal("new_screen", screen)



enum Stage{
	PLAN, PLAY
}
signal new_stage(stage)
var stage = Stage.PLAN setget set_stage
func set_stage(new_stage):
	stage = new_stage
	emit_signal("new_stage", stage)



enum Mode{
	PICK_ANGLE, PICK_POWER, PICK_IMPACT, NONE
}
signal new_mode(mode)
var mode = Mode.NONE setget set_mode
func set_mode(new_mode):
	mode = new_mode
	emit_signal("new_mode", mode)



var turn = 0 setget set_turn
var player_turn
signal new_turn(turn, player)
func set_turn(new_turn):
	turn = new_turn
	player_turn = get_child(turn % get_child_count())
	emit_signal("new_turn", turn, player_turn)



const ball_styles = [
	"default"
]
var ball_style = 0 setget set_ball_style
signal new_ball_style(style)
func set_ball_style(new_style):
	ball_style = new_style
	emit_signal("new_ball_style", ball_style)

func get_ball_styles_dir(style):
	return "res://ball/styles/" + ball_styles[style] + "/"



const table_styles = [
	
]
var table_style
signal new_table_style(style)

const cue_styles = [
	
]
var cue_style
signal new_cue_style(style)

var world = null

func _ready():
	new_player()
	player_turn = get_child(0)

func _process(delta):
	pass

func game_in_progress():
	return screen == Screen.GAME

func new_player():
	add_child(player_class.new())