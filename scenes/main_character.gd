extends CharacterBody2D

# Constant variables
const SPEED = 300.0
const JUMP_VELOCITY = -450.0
@onready var sprite_2d = $Sprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var last_direction = 1
var controllable = true
var start_position : Vector2

func _ready():
	global_position = start_position

func _physics_process(delta):
	if (!controllable):
		return
	# Walking
	if (velocity.x > 1 || velocity.x < -1):
		sprite_2d.animation = "running"
	else:
		sprite_2d.animation = "idle"
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		sprite_2d.animation = "jumping"

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

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
	visible = true
	controllable = true
	global_position = start_position
	velocity = Vector2.ZERO

func char_death():
	#print("Player died.")
	visible = false
	controllable = false
	await get_tree().create_timer(1).timeout
	reset()

