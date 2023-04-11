extends KinematicBody2D

const MAX_SPEED = 70

enum {
	IDLE,
	WANDERING,
	CHASING
}

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
var state = IDLE
onready var stats = $Stats
onready var DetectionZone = $DectectionZone
onready var _burger_drop = preload("res://Item/BurgerDrop.tscn")
onready var hurtbox = $Hurtbox
onready var softCollision = $SoftCollision
onready var wanderController = $WanderingController

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 600 * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = Vector2.ZERO
			chase_player()
			if wanderController.get_time_left() == 0:
				state = state_change([IDLE, WANDERING])
				wanderController.start_wandering_timer(rand_range(1, 4))
		WANDERING:
			chase_player()
			if wanderController.get_time_left() == 0:
				state = state_change([IDLE, WANDERING])
				wanderController.start_wandering_timer(rand_range(1, 4))
			var direction = global_position.direction_to(wanderController.wander_position)
			velocity = direction * MAX_SPEED
			
			if global_position.distance_to(wanderController.wander_position) <= 4:
				velocity = Vector2.ZERO
			
		CHASING:
			var player = DetectionZone.player
			if player != null:
				var direction = global_position.direction_to(player.global_position)
				velocity = direction * MAX_SPEED
			else:
				state = IDLE
				
	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 400
	velocity = move_and_slide(velocity)

func chase_player():
	if DetectionZone.PlayerDetected():
		state = CHASING

func state_change(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func _on_Hurtbox_area_entered(area):
	stats.hp -= area.damage
#	hurtbox.start_invin(0.5)
#	hurtbox.on_hit()
	knockback = area.knockback_vector * 200
	
func _on_Stats_dead():
	randomize()
	if randf() > 0.3:
		var burger_drop = _burger_drop.instance()
		get_parent().add_child(burger_drop)
		burger_drop.global_position = self.global_position
	queue_free()

