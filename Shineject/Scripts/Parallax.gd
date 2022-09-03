extends ParallaxBackground

var velocity := 0.05

func _process(delta):
	_set_parallax($Parallax_1, velocity, delta)
	_set_parallax($Parallax_2, velocity / 2, delta)
	pass

func _set_parallax(parallax, velocity, delta):
	parallax.set_motion_offset(Vector2(round(get_scroll_offset().x * velocity + delta), round(get_scroll_offset().y * velocity + delta)))
	pass
