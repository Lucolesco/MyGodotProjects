extends KinematicBody2D

var motion = Vector2.ZERO
var speed = 300
var accel = 0.3

func _process(delta):
	
	var dir = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	motion.x = lerp(motion.x, speed * dir, accel)
	motion = move_and_slide(motion)
	
	pass
