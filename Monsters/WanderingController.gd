extends Node2D

export(int) var wandering_range = 64

onready var start_position = global_position
onready var wander_position = global_position
onready var timer = $Timer


func _ready():
	update_wander_position()

func update_wander_position():
	var wandering_vector = Vector2(rand_range(-wandering_range, wandering_range), rand_range(-wandering_range, wandering_range))
	wander_position = start_position + wandering_vector

func get_time_left():
	return timer.time_left

func start_wandering_timer(duration):
	timer.start(duration)

func _on_Timer_timeout():
	update_wander_position()
