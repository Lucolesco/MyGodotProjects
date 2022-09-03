extends AnimatedSprite

func _process(delta):
	
	#Dynamic animation's speed based on enemy's motion
	self.speed_scale = get_parent().motion.x / 100 * sign(get_parent().motion.x)
	#Flips the sprite based on enemy's direction
	self.flip_h = bool(get_parent().dir + 1)
	
	scale.y = lerp(scale.y, 1 + clamp(get_parent().motion.y, 0, 0.2), 0.1)
	
	pass
