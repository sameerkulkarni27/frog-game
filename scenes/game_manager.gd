extends Node

var points = 0
@onready var points_label = $"../UI/Panel/PointsLabel"

func add_cherry_points():
	points += 1
	#print(points)
	points_label.text = "POINTS: " + str(points)

func add_melon_points():
	points += 2
	#print(points)
	points_label.text = "POINTS: " + str(points)

