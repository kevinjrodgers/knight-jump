extends Area2D

@onready var timer: Timer = $Timer


func _on_body_entered(body: Node2D) -> void:
	# When the player enters the Killzone's body, a timer starts
	# Once the timer is completed, timeout() will run, which will reload/restart the scene
	print("You have died...")
	if body.has_method("die"):
		body.die()
	Engine.time_scale = 0.5 # Sets to half speed
	body.get_node("CollisionShape2D").queue_free()
	timer.start()


func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
	
