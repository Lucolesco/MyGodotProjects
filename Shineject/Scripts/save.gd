extends Node

onready var player = get_node("/root/main/entities/player")

func _ready():
	var new_position = _load()
	var o = str2var(new_position)
	player.position = o
	pass


func _process(delta):
	if(Input.is_action_just_pressed("ui_home")):
		_save(var2str(player.position))
		pass
	pass

func _load():
	var file = File.new()
	file.open("res://save.lesco", File.READ)
	var content = file.get_as_text()
	file.close()
	return content
	pass

func _save(content):
	var file = File.new()
	file.open("res://save.lesco", File.WRITE)
	file.store_string(content)
	file.close()
	pass
