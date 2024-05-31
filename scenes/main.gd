extends Node

@onready var character_body_2d = $SceneObjects/CharacterBody2D
@onready var player_start = $SceneObjects/PlayerStart

func _ready():
	character_body_2d.start_position = player_start.global_position
	character_body_2d.global_position = character_body_2d.start_position
