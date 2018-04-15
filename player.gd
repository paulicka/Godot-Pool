extends Node

signal my_turn()

func _ready():
	Game.connect("new_mode", self, "lock_camera")

func _process(delta):
	if Game.game_in_progress():
		process_world(Game.world, delta)

func _input(event):
	if Game.stage == Game.Stage.PLAY: return
	if event.is_action("pick_yaw"):
		Game.set_mode(Game.Mode.PICK_ANGLE)
	if event.is_action("pick_power"):
		Game.set_mode(Game.Mode.PICK_POWER)
	if event.is_action("pick_impact"):
		Game.set_mode(Game.Mode.PICK_IMPACT)
	if event.is_action("roam"):
		Game.set_mode(Game.Mode.ROAM)

func process_world(world, delta):
	match Game.stage:
		Game.Stage.PLAN:
			match Game.mode:
				Game.Mode.PICK_ANGLE:
					free_move(world, delta, false)
				Game.Mode.PICK_POWER:
					free_move(world, delta, false)
				Game.Mode.PICK_IMPACT:
					free_move(world, delta, false, false)
				Game.Mode.ROAM:
					free_move(world, delta)
		Game.Stage.PLAY:
			free_move(world, delta)

func lock_camera(mode):
	match mode:
		Game.Mode.PICK_ANGLE:
			continue
		Game.Mode.PICK_POWER:
			continue
		Game.Mode.PICK_IMPACT:
			var t = Game.world.get_cue_ball.translation
			Game.world.get_camera().move_to(Vector2(t.x, t.y))

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