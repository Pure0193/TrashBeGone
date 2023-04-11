extends Area2D

var invincible = false setget set_invincible

signal invincibility_start
signal invincibility_end

onready var timer = $Timer

func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invincibility_start")
	else:
		emit_signal("invincibility_end")

func start_invin(duration):
	self.invincible = true
	timer.start(duration)

func on_hit():
	var main = get_tree().current_scene


func _on_Timer_timeout():
	self.invincible = false

func _on_Hurtbox_invincibility_start():
	set_deferred("monitoring", false)
#	print("started")


func _on_Hurtbox_invincibility_end():
	monitoring = true
#	print("ended")
