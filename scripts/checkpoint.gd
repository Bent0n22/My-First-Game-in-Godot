extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("checkpoint")
		if body.has_method("set_checkpoint"):
			body.set_checkpoint(global_position)
