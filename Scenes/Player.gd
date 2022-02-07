extends KinematicBody

var vec = Vector3.ZERO
var fall_acceleration = 10
var speed = 4


func _physics_process(delta):
	var move_direction := Vector3.ZERO
	move_direction.z = Input.get_action_strength("forward") - Input.get_action_strength("backward")
	move_direction.x = Input.get_action_strength("left") - Input.get_action_strength("right")
	if Input.is_action_pressed("left"):
		self.rotate_y(0.08)
	elif Input.is_action_pressed("right"):
		self.rotate_y(-0.08)
	move_direction = move_direction.rotated(Vector3.UP, self.rotation.y).normalized()
	
	vec.z = -move_direction.z * speed
	vec.x = -move_direction.x * speed
	vec.y -= fall_acceleration * delta
	
	vec = move_and_slide(vec, Vector3.UP)
