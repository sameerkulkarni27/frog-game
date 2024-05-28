extends StaticBody2D

var time = 1
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += 1
	$Sprite2D.position += Vector2(0, sin(time) * 2)


func _on_player_on_top_body_entered(body):
	if (body.name == "CharacterBody2D"):
		set_process(true)
		timer.start(1)

func _on_timer_timeout():
	queue_free()
