extends Area2D

@onready var game_manager = %GameManager
@onready var particle = preload("res://scenes/collected_particle.tscn")

func _on_body_entered(body):
	if (body.name == "CharacterBody2D"):
		game_manager.add_cherry_points()
		queue_free()
		
		var collected = particle.instantiate()
		collected.global_position = $Marker2D.global_position
		get_parent().add_child(collected)
		
