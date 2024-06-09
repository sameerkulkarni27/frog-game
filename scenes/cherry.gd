extends Area2D

@onready var game_manager = %GameManager
@onready var animation_player = $AnimationPlayer

func _on_body_entered(body):
	if (body.name == "CharacterBody2D"):
		game_manager.add_cherry_points()
		animation_player.play("collected_animation")
		queue_free()
