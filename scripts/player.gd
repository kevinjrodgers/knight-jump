extends CharacterBody2D

var isDead: bool = false
const SPEED = 130.0
const MAX_JUMP = -300.0
const MIN_JUMP = -100.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D 
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound
@onready var death_sound: AudioStreamPlayer2D = $DeathSound
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func die():
	isDead = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = MAX_JUMP
		jump_sound.play()

	# Get the input direction (-1, 0, or 1) and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flips the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	# Play animations
	if is_on_floor():
		if direction == 0:
			if Input.is_action_pressed("duck"):
				animated_sprite.play("duck")
			else:
				animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
		
	# Applies movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if isDead == true:
		animated_sprite.play("death")
		animation_player.play("death")
		
