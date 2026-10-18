extends AnimatedSprite2D




@onready var animated_sprite_2d: AnimatedSprite2D = $"."



func _on_checkpoint_area_entered(area: Area2D) -> void:
	if area.name == "playerarea":
		animated_sprite_2d.play("checkflag")
