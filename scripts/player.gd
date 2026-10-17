extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
var spawn_point = Vector2.ZERO

@onready var ladder_ray_cast: RayCast2D = $LadderRayCast
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var end_ray: RayCast2D = $EndRay


func _physics_process(delta: float) -> void:
	var laddercollider = ladder_ray_cast.get_collider()
	var gamending = end_ray.get_collider()

	if gamending: get_tree().change_scene_to_file("res://scenes/end_screen.tscn")
	
	if laddercollider: _ladder_climb(delta)
	else: _movement(delta)
	
	if global_position.y >= 500:
		print("you fell")
		spawn_player(spawn_point)
	
	move_and_slide()

func _ladder_climb(_delta):
	var directionx := Input.get_axis("move_left", "move_right")
	var directiony := Input.get_axis("move_up", "move_down")
	#Flip the player
	if directionx > 0:
		animated_sprite.flip_h = false
	elif directionx < 0:
		animated_sprite.flip_h = true

# Play Animation

	if is_on_floor():
		if directionx == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("Run")
	else:
		animated_sprite.play("Climb") 

# Apply movement
	if directionx:
		velocity.x = directionx * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if directiony:
		velocity.y = directiony * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	#Jumping off ladder
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY

func spawn_player(spawn_point):
	if spawn_point == Vector2.ZERO:
		get_tree().reload_current_scene()
		return
	
	global_position = spawn_point
	
	
func set_checkpoint(global_position):
	spawn_point = global_position

func _movement(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get input direction: -1, 0, 1
	var directionx := Input.get_axis("move_left", "move_right")
	#Flip the player
	if directionx > 0:
		animated_sprite.flip_h = false
	elif directionx < 0:
		animated_sprite.flip_h = true

# Play Animation
	if is_on_floor():
		if directionx == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("Run")
	else:
		animated_sprite.play("Jump") 

# Apply movement
	if directionx:
		velocity.x = directionx * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
