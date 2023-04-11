extends Control

onready var health_bar = $HealthBar
onready var health_label = $HealthLabel
onready var max_health_label = $MaxHealthLabel

	
func set_max_health(value):
	health_bar.max_value = value
	max_health_label.text = "/" + String(value)
	
func set_health(value):
	health_bar.value = value
	health_label.text = String(value)

func _ready():
	self.set_max_health(PlayerStats.max_hp)
	self.set_health(PlayerStats.hp)
	PlayerStats.connect("hp_changed", self, "set_health")
	PlayerStats.connect("max_hp_changed", self, "set_max_health")
