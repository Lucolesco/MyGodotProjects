extends KinematicBody2D

const gravity := 15
const up := Vector2.UP

var motion := Vector2.ZERO
var knock_width := 150
var knock_height := 200
var can_jump := false
var dir := 0.0
var snap := Vector2.ZERO

var health := 1

var attack := 10

onready var player := get_node("/root/main/player")

func _physics_process(delta):
	#GETTING PLAYER POSITION AND DEFINING ENEMY'S DIRECTION
	
	dir = sign(player.position.x - position.x)
	
	motion.y += gravity
	motion = move_and_slide_with_snap(motion, snap, up, true)
	
	#CALLING SNAP EVERY FRAME TO ENABLE GRAVITY
	
	snap = Vector2(0, 16)
	
	can_jump = is_on_wall() && !_colliding("player")
	
	match(is_on_floor()):
		true:
			snap = Vector2.ZERO
			motion.x = lerp(motion.x, (player.speed/2) * dir, 0.3)
			
			_play_audio($enemy_audiowalking, "once")
			
			match(_colliding("player") && !can_jump):
				true:
					
					# SETTING UP KNOCKBACK
					
					_attack(attack)
					
					player.position.x += 1 * dir
					player.position.y -= 1
					
					motion.x += knock_width * dir * -1
					motion.y -= knock_height
					
			if can_jump: 
				motion.y -= player.jump_height
	
	match(can_jump):
		true:
			motion.x = (player.speed/2) * dir
	
	
	if _colliding("bullet"):
		health -= 1
	if(health < 1):
		queue_free()
	
	pass

func _colliding(bodyCollided):
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == bodyCollided:
			return true
	pass
	
	return false

func _attack(attack):
	player.health -= attack

func _play_audio(audio, status):
	match status:
		"once":
			audio.stop()
			audio.play()
	return
	pass

func _get_damage():
	self.health -= 1
	
