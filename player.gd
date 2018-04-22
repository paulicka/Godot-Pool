extends Node

signal my_turn()

var roam = true

func _ready():
	pass

func _process(delta):
	if Game.game_in_progress():
		process_world(Game.world, delta)

func _input(event):
	if not event.is_pressed(): return
	
	if event.is_action("roam"):
		roam = !roam
	
	if Game.stage == Game.Stage.PLAY: return
	
	if event.is_action("pick_yaw"):
		Game.set_mode(Game.Mode.PICK_ANGLE)
	if event.is_action("pick_power"):
		Game.set_mode(Game.Mode.PICK_POWER)
	if event.is_action("pick_impact"):
		Game.set_mode(Game.Mode.PICK_IMPACT)
	

func process_world(world, delta):
	if roam:
		free_move(world, delta)
	else:
		lock_camera()
		free_move(world, delta, false)

func lock_camera():
	var t = Game.world.get_cue().global_transform.origin
	Game.world.get_camera().move_to(Vector2(t.x, t.z))

func free_move(world, delta, allow_move = true, allow_pan = true, allow_zoom = true):
	if allow_move:
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
	
	if allow_pan:
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
	
	if allow_zoom:
		var zoom = 0.0
		var delta_zoom = 12.0 * delta
		if Input.is_key_pressed(KEY_T):
			zoom -= delta_zoom
		if Input.is_key_pressed(KEY_G):
			zoom += delta_zoom
		world.get_camera().zoom(zoom)