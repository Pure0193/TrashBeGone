extends KinematicBody2D

const MAX_SPEED = 150

enum {
	MOVE,
	ATTACK
}

var regen_amount = 1
var state = MOVE
var velocity = Vector2.ZERO
var knockback_direction = Vector2.LEFT
var stats = PlayerStats
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var attackHitbox = $HitboxPivot/AttackHitbox
onready var hurtbox = $Hurtbox
onready var regenTimer = $RegenTimer
onready var DeathScreen = $DeathScreen
onready var PlayerSprite = $Sprite

func _ready():
	randomize()
	stats.connect("dead", self, "PlayerDeath")
	animationTree.active = true
	attackHitbox.knockback_vector = knockback_direction
	DeathScreen.visible = false

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state(delta)
	

# Player Movement and its Animation
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()		# to avoid faster speed when moving in diagonal direction
	
	if input_vector != Vector2.ZERO:
		knockback_direction = input_vector
		attackHitbox.knockback_vector = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Walk/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationState.travel("Walk")
		velocity = input_vector * MAX_SPEED
	else:
		animationState.travel("Idle")
		velocity = Vector2.ZERO
	
	velocity = move_and_slide(velocity)			# keep the velocity value so that after the collision occur, left over velocity will still be carry on
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
		$Attack_Sound.play()

func attack_state(delta):
	animationState.travel("Attack")

func attack_animation_finished():
	state = MOVE

func _on_Hurtbox_area_entered(area):
	stats.hp -= area.get_parent().get_node("Stats").mon_dmg
	$PlayerGetHit.play()
	hurtbox.start_invin(0.7)
	hurtbox.on_hit()


func _on_RegenTimer_timeout():
	if stats.hp < stats.max_hp:
		stats.set_hp(stats.hp + regen_amount)

func PlayerDeath():
	WorldSoundEffect.PlayerDiedSound()
	queue_free()
#	PlayerSprite.visible = false
#	DeathScreen.visible = true
