extends Node2D

var timeout := 1
var delay := timeout

var enemy_node := preload("res://Objects/enemy.tscn")
var paused := false

func _ready():
	
	#PLAYER'S SIGNALS
	$player.connect("current_state", $player/player_sprite, "_get_current_state")
	$player.connect("health_and_stamina", $CanvasLayer/GUI, "_get_health_and_stamina")
	$player/player_sprite.connect("current_frame_and_animation", $player/audio, "_get_current_frame_and_animation")
	$player.connect("player_dead", self, "_is_player_dead")
	$player.connect("instance_bullet", self, "_instance_bullet")
	$player.connect("instance_bullet", $player/audio, "_instance_bullet")
	
	pass

func _process(delta):
	
	if(Input.is_action_just_pressed("ui_leftclick")):
		_instance_on_mouse(enemy_node, $entities)
	if(Input.is_action_just_pressed("ui_cancel")):
		_pause()
	if(Input.is_action_just_pressed("r")): 
		_reload_scene()
	
	pass

func _pause():
	paused = !paused
	get_tree().paused = paused 
	pass

func _reload_scene():
	get_tree().reload_current_scene()
	print("Scene reloaded!")
	pass
	
	pass

func _instance_on_mouse(node, to):
	var instance = node.instance()
	instance.position = get_global_mouse_position() / scale
	to.add_child(instance)
	pass

func _instance_enemy():
	var enemy = enemy_node.instance()
	enemy.position = Vector2(0, 30)
	$entities.add_child(enemy)
	pass

func _is_player_dead():
	print("The player died!")
	get_tree().reload_current_scene()
	pass

func _instance_bullet(bullet):
	add_child(bullet)
	pass

func _on_RespawnTime_timeout():
	_instance_enemy()
	pass 

