extends KinematicBody2D

onready var bullet_node = preload("res://Objects/bullet.tscn")

var delay := 0.0
var timeout := 0.1

var gravity := 15
var stamina := 100.0
var health := 100
var attacking := false
var motion := Vector2.ZERO
var snap := Vector2.ZERO
var up := Vector2.UP
var move := 0
var hsp := 0
var pos := Vector2.ZERO

var speed := 200
var accel := 0.15
var stamina_drain = 50
var jump_height := 350

var rng := RandomNumberGenerator.new()

signal current_state
signal player_dead
signal instance_bullet
signal health_and_stamina

func _physics_process(delta):
	
	move = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	hsp = speed * move
	attacking = Input.is_action_pressed("ui_attack")
	
	snap = Vector2(0, 24)
	
	health = clamp(health, 0, 100)
	stamina = clamp(stamina, 0, 100.0)
	_stamina(delta, stamina_drain)
	emit_signal("health_and_stamina", health, stamina)
	
	_jump(jump_height)
	_get_current_state()
	_accel()

	motion.y += gravity 
	motion = move_and_slide_with_snap(motion, snap, up, true)
	
	dead()
	pass

func dead():
	if health < 1:
		emit_signal("player_dead")
	pass

func _get_current_state():
	var current_state = ""
	
	current_state = "idle"
	
	if(move != 0):
		current_state = "walking"
	
	if(!is_on_floor()):
		current_state = "falling"
	
	if(attacking):
		current_state += "_attack"
	
	emit_signal("current_state", current_state, move, motion)
	
	pass
	
func _instancebullet():
	
	rng.randomize()
	
	var r := 5
	var bullet = bullet_node.instance()
	var offset = rng.randi_range(-r, r)
	
	var bulletType = rng.randi_range(0, 3)
	var color_intesity = rng.randf_range(50, 205)
	
	var dir := -1
	if(int($player_sprite.flip_h) == 0):
		dir = 1
	
	
	
	#KNOCKBACK
	bullet.position = Vector2(self.position.x + (10 + r/2) * dir, self.position.y - 14 + offset)
	bullet.get_child(0).frame = bulletType
	bullet.get_child(0).modulate = Color(1, color_intesity/255, 0, 1)
	bullet.dir = dir
	
	emit_signal("instance_bullet", bullet)
	
	pass

func _stamina(delta, stamina_drain):
	if(!attacking):
		stamina += stamina_drain * delta
		return
	
	if(stamina > 0):
		stamina -= stamina_drain * delta
	return

	pass
	
	pass

func _jump(jump_height):
	if(is_on_floor() && Input.is_action_just_pressed("ui_up")):
		snap = Vector2.ZERO
		motion.y -= jump_height
	pass

func _accel():
	if(move != 0):
		motion.x = lerp(motion.x, hsp, accel)
		return
	motion.x = lerp(motion.x, 0, accel * 2)
	pass

func _on_Cooldown_timeout():
	if(attacking && stamina > 0):
		_instancebullet()
	pass 
