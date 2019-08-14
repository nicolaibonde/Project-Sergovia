extends Area2D



func _on_PatrollingBoundry_body_entered(body):
	if not body.get("boundry_group") == null:
		for group in self.get_groups():
			if group == body.boundry_group:
				if body.has_method("turn_around"):
					body.turn_around()
