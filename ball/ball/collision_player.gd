extends AudioStreamPlayer3D

enum Sample{
	BALL_COLLISION
	CUE_HIT
}

func _init(sample, pitch = 1.0):
	match sample:
		BALL_COLLISION:
			stream = preload("ball_collision.wav")
	
	attenuation_model = ATTENUATION_INVERSE_SQUARE_DISTANCE
	#unit_db = -5.0
	pitch_scale = pitch
	unit_size = 25.0
	bus = "BallCollision"
	
	connect("finished", self, "queue_free")

func _enter_tree():
	play()
