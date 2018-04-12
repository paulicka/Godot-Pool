extends Node

signal my_turn()

func _ready():
	pass

func _process(delta):
	if Game.game_in_progress():
		process_world(Game.world, delta)

func process_world(world, delta):
	var move = Vector2()
	var movement = 18.0 * delta
	if Input.is_key_pressed(KEY_W):
		move.y -= movement
	if Input.is_key_pressed(KEY_S):
		move.y += movement
	if Input.is_key_pressed(KEY_A):
		move.x -= movement
	if Input.is_key_pressed(KEY_D):
		move.x += movement
	world.get_camera().translate(move)
	
	var yaw = 0.0
	var pitch = 0.0
	var delta_yaw = 1.0 * delta
	var delta_pitch = 0.4 * delta
	if Input.is_key_pressed(KEY_Q):
		yaw -= delta_yaw
	if Input.is_key_pressed(KEY_E):
		yaw += delta_yaw
	if Input.is_key_pressed(KEY_R):
		pitch += delta_pitch
	if Input.is_key_pressed(KEY_F):
		pitch -= delta_pitch
	world.get_camera().rotate(yaw, pitch)
	
	var zoom = 0.0
	var delta_zoom = 12.0 * delta
	if Input.is_key_pressed(KEY_T):
		zoom -= delta_zoom
	if Input.is_key_pressed(KEY_G):
		zoom += delta_zoom
	world.get_camera().zoom(zoom)