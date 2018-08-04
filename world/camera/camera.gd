extends Spatial

const FACTOR = 7.0
const MAX_PITCH = PI/2 - 0.1
const MIN_PITCH = 0.1
const MAX_ZOOM = 45.0
const MIN_ZOOM = 5.0
const MARGIN = 12.0

var yaw = 0.0
var pitch = 0.6
var zoom = (MAX_ZOOM + MIN_ZOOM) / 2.0
var pos = Vector2()

func _ready():
	pass

func _process(delta):
	var width = Game.world.get_table().ACTUAL_TABLE_WIDTH + MARGIN
	var height = Game.world.get_table().ACTUAL_TABLE_HEIGHT + MARGIN
	pos.x = clamp(pos.x, -width, width)
	pos.y = clamp(pos.y, -height, height)
	
	var current_pos = Vector2(translation.x, translation.z)
	current_pos += (pos - current_pos) * min(1.0, FACTOR * delta)
	translation.x = current_pos.x
	translation.z = current_pos.y
	
	rotation.y = yaw
	rotation.x = -pitch
	
	$Camera.translation.z = zoom

func move_to(move):
	pos = move

func translate(amount):
	amount = amount.rotated(-yaw)
	pos += amount

func rotate(yaw_amount, pitch_amount):
	pitch = clamp(pitch + pitch_amount, MIN_PITCH, MAX_PITCH)
	yaw += yaw_amount

func zoom(amount):
	zoom = clamp(zoom + amount, MIN_ZOOM, MAX_ZOOM)

func project_ray(point):
	var from = $Camera.project_ray_origin(point)
	#var from = $Camera.global_transform.origin
	var to = from + $Camera.project_ray_normal(point) * 1000
	var result = get_world().direct_space_state.intersect_ray(from, to, [], 0x2)
	if result:
		return result.position
	else:
		return null