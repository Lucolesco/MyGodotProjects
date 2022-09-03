extends Node

func _get_current_frame_and_animation(frame, animation):
	match(animation):
		"idle":
			$player_audiowalking.stop()
		"idle_attack":
			$player_audiowalking.stop()
		_:
			match(frame):
				0:
					$player_audiowalking.play()
					$player_audiowalking.stop()
				3:
					$player_audiowalking.play()
					$player_audiowalking.stop()
	pass

func _instance_bullet(bullet):
	$player_weapon1_equip.play()
