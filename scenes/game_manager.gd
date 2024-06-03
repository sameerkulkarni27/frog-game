extends Node

var points = 0
var cherries = 0
var melons = 0 

@onready var points_label = $"../UI/Panel/PointsLabel"
@onready var cherries_label = $"../UI/Panel/CherriesLabel"
#$CherriesLabel
@onready var melons_label = $"../UI/Panel/MelonsLabel"
#$MelonsLabel

func add_cherry_points():
	points += 1
	cherries += 1
	#print(points)
	cherries_label.text = "CHERRIES:" + str(cherries)
	points_label.text = "POINTS:" + str(points)

func add_melon_points():
	points += 2
	melons += 1
	#print(points)
	melons_label.text = "MELONS:" + str(melons)
	points_label.text = "POINTS:" + str(points)

