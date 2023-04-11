extends Area2D

var stats = PlayerStats

var damage: int = stats.damage
var knockback_vector = Vector2.ZERO

func _ready():
	stats.connect("dmg_changed", self, "set_dmg")

func set_dmg():
	damage = stats.damage
