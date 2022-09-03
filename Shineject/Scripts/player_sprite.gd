extends AnimatedSprite

signal current_frame_and_animation

func _get_current_state(state, move, motion):
	#Flips the sprite based on player's direction
	#$Particles.emitting = false
	
	if(move != 0):
		self.flip_h = bool(move - 1)
		self.speed_scale = abs(motion.x/100)
		#r$Particles.emitting = true
	
	scale.y = lerp(scale.y, 1 + clamp(motion.y, 0, 0.1), 0.05)
	
	#THIS GETS THE FIRST FRAME OF THE CURRENT ANIMATION
	var initial_frame := get_frame() 
	set_animation(state)
	
	#DISPLAY THE ANIMATION ACCORDINGLY TO ITS INDEX FRAME
	set_frame(initial_frame) 
	
	emit_signal("current_frame_and_animation", get_frame(), get_animation())
	
	pass
