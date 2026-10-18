extends AnimatedSprite2D

const SPEED = 60

var direction = 1
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var evil_mushroom: AnimatedSprite2D = $"."

func _process(delta: float) -> void:
	if ray_cast_right.is_colliding():
		direction = -1
		evil_mushroom.flip_h = false
	if ray_cast_left.is_colliding():
		direction = 1
		evil_mushroom.flip_h = true
	
	
	position.x += direction * SPEED * delta
