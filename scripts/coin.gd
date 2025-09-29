extends Area2D

# A unique node, can only be accessed within the same scene
@onready var game_manager: Node = %GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer



func _on_body_entered(_body: Node2D) -> void:
	pass # Replace with function body.
	print("+1 coin!")
	game_manager.add_point()
	animation_player.play("pickup")
