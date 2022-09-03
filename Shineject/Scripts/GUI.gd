extends MarginContainer

onready var HealthBar = $VBoxContainer/HealthBar
onready var StaminaBar = $VBoxContainer/StaminaBar

func _get_health_and_stamina(health, stamina):
	HealthBar.value = lerp(HealthBar.value, health, 0.5)
	StaminaBar.value = stamina
	pass
