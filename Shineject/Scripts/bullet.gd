extends KinematicBody2D

const gravity = 14

var motion = Vector2.ZERO

var jump_height = 300
var force = 200
var dir = 0

var times_bounced = 5

var rotation_vel = 100

func _physics_process(delta):
	
	_wall()
	_jump()
	
	motion.x = force * dir
	$bullet_spr.rotation += rotation_vel * dir * delta
	
	motion = move_and_slide(motion, Vector2.UP)
	
	_bounces()
	
	pass

func _jump():
	if(!is_on_floor()):
		motion.y += gravity
		return 
	
	set_scale(get_scale()/2)
	jump_height /= 2
	rotation_vel /= 2
	times_bounced -= 1
	motion.y -= jump_height
	
	return
	
	pass

func _wall():
	if(!is_on_wall()):
		return
		
	set_scale(get_scale()/2)
	rotation_vel /= 2
	times_bounced -= 1
	jump_height /= 2
	force /= 2
	dir *= -1
	return
	
	pass

func _bounces():
	if times_bounced < 0:
		queue_free()
		
func _colliding(bodyCollided):
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == bodyCollided:
			return true
	pass
	
	return false
