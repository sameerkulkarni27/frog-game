extends CharacterBody2D

# Constant variables
const SPEED = 300.0
const JUMP_VELOCITY = -450.0
@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer

@onready var appearingParticle = preload("res://scenes/appearing_particle.tscn")
@onready var marker_2d = $Marker2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var last_direction = 1
var controllable = true
var start_position : Vector2
var jump_count = 0
var jump_max = 1

func _ready():
	global_position = start_position
	check_level()
	char_death()

func _physics_process(delta):
	if (!controllable):
		return
	# Walking
	if (velocity.x > 1 || velocity.x < -1):
		#sprite_2d.animation = "running"
		animation_player.play("run_animation")
	else:
		#sprite_2d.animation = "idle"
		animation_player.play("idle_animation")
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
		if (jump_count == 1):
			#sprite_2d.animation = "jumping"
			animation_player.play("jump_animation")
		elif (jump_count == 2):
			#sprite_2d.animation = "double_jump"
			animation_player.play("doublejump_animation")

	if jump_count != 0 and is_on_floor():
		jump_count = 0
	
	# Handle jump.
	#if Input.is_action_just_pressed("jump") and is_on_floor():
	if Input.is_action_just_pressed("jump") and jump_count < jump_max:
		velocity.y = JUMP_VELOCITY
		jump_count += 1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		last_direction = direction
	else:
		velocity.x = move_toward(velocity.x, 0, 25.0)

	move_and_slide()
	
	sprite_2d.flip_h = last_direction < 0

func reset():
	global_position = start_position
	
	var appearing = appearingParticle.instantiate()
	appearing.global_position = marker_2d.global_position
	get_parent().add_child(appearing)
	
	await appearing.animation_finished
	
	visible = true
	controllable = true
	#global_position = start_position
	velocity = Vector2.ZERO
	

func char_death():
	#print("Player died.")
	visible = false
	controllable = false
	await get_tree().create_timer(1).timeout
	reset()

func check_level():
	var current_level = get_tree().current_scene
	#print("current level: " + str(current_level.name))
	if (current_level.name == "Level2"):
		jump_max = 2
	else:
		jump_max = 1
