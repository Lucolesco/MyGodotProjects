extends Node

var song = ""

func _ready():
	song = _load()
	
	pass


func _process(delta):
	if Input.is_action_just_pressed("ui_down"):
		_save("vai tomar no cu maluco")
	
	print(song)
	
	pass

func _load():
	var file = File.new()
	file.open("../metadata.lesco", File.READ)
	var content = file.get_as_text()
	file.close()
	return content
	pass

func _save(content):
	var file = File.new()
	file.open("metadata.lesco", File.WRITE)
	file.store_string(content)
	file.close()
	pass
