extends Node

signal my_turn()

func _ready():
	pass

func _process(delta):
	if Game.game_in_progress():
		process_world(Game.world, delta)

func _input(event):
	pass

func process_world(world, delta):
	match Game.stage:
		Game.Stage.PLAN:
			match Game.mode:
				Game.Mode.PICK_YAW:
					pass
				Game.Mode.PICK_PITCH:
					pass
				Game.Mode.PICK_IMPACT:
					pass
				Game.Mode.ROAM:
					free_move(world, delta)
		Game.Stage.PLAY:
			free_move(world, delta)

func free_move(world, delta):
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