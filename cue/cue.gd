extends Spatial

const min_dist = 2.0
const max_dist = 12.0

const min_power = 1.0
const max_power = 200.0

var rot = 0.0
var power = min_dist

var time = 0.0

func _ready():
	Game.connect("new_mode", self, "_new_mode")
	Game.connect("new_stage", self, "_new_stage")
	$CueTip/CueMesh.translation.x = -32 - power

func _process(delta):
	translation = Game.world.get_cue_ball().translation
	
	if Game.stage != Game.PLAN: return
	if not Game.is_current_turn(): return
	
	match Game.mode:
		Game.Mode.PICK_ANGLE:
			var cue_pos = global_transform.origin
			cue_pos = Util.to_vec2(cue_pos)
			var cursor_pos = Game.world.cursor_pos
			rot = -cursor_pos.angle_to_point(cue_pos)
			
			rotation.y = rot
			calculate_ball_indicator()
		
		Game.Mode.PICK_POWER:
			var cue_pos = global_transform.origin
			cue_pos = Util.to_vec2(cue_pos)
			var cursor_pos = Game.world.cursor_pos
			var dist = cursor_pos - cue_pos
			dist = dist.rotated(rot)
			power = -dist.x
			power = clamp(power, min_dist, max_dist)
			
			$CueTip/CueMesh.translation.x = -32 - power
			var linear_power = range_lerp(power, min_dist, max_dist, 0.04, 0.98)
			$PowerInfo/PowerIcon.material_override.set_shader_param("power", linear_power)
			time += delta * (linear_power * linear_power + 0.1) * 0.7
			# Make tool script to see this animated
			$PowerInfo/PowerIcon.material_override.set_shader_param("time", time)

func calculate_ball_indicator():
	var result = Game.world.get_cue_ball().cast(Util.angle_vec2(rot, 1))
	if result:
		var point = result["point"]
		var distance = Util.to_vec2(translation).distance_to(point)
		$CueTrajectory/CollisionIcon.translation.x = distance
	else:
		# Hit a wall. (For some reason cast_motion doesn't detect plane shapes)
		var width  = Game.world.get_table().ACTUAL_TABLE_WIDTH - Game.world.get_cue_ball().BALL_SIZE
		var height = Game.world.get_table().ACTUAL_TABLE_HEIGHT - Game.world.get_cue_ball().BALL_SIZE
		
		var top_left  = Vector2(-width, height)
		var top_right = Vector2(width, height)
		var bot_left  = Vector2(-width, -height)
		var bot_right = Vector2(width, -height)
		
		var start = Util.to_vec2(translation)
		var end = start + Util.angle_vec2(rot, 100)
		end.y = -end.y
		
		var intersection = null
		intersection = Geometry.segment_intersects_segment_2d(start, end, top_left, top_right)
		if intersection == null:
			intersection = Geometry.segment_intersects_segment_2d(start, end, bot_left, bot_right)
		if intersection == null:
			intersection = Geometry.segment_intersects_segment_2d(start, end, top_left, bot_left)
		if intersection == null:
			intersection = Geometry.segment_intersects_segment_2d(start, end, top_right, bot_right)
		if intersection != null:
			$CueTrajectory/CollisionIcon.translation.x = start.distance_to(intersection)

func get_power():
	return range_lerp(power, min_dist, max_dist, min_power, max_power)

func get_angle():
	return rot

func hit():
	pass

func _new_mode(mode):
	match mode:
		Game.Mode.PICK_ANGLE:
			$AngleInfo.show()
			$PowerInfo.hide()
		Game.Mode.PICK_POWER:
			$AngleInfo.hide()
			$PowerInfo.show()
		Game.Mode.PICK_IMPACT:
			$AngleInfo.hide()
			$PowerInfo.hide()
		Game.Mode.NONE:
			$AngleInfo.hide()
			$PowerInfo.hide()

func _new_stage(stage):
	if stage == Game.Stage.PLAN:
		visible = true
		calculate_ball_indicator()
	else:
		visible = false