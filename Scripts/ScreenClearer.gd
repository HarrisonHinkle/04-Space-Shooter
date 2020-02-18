extends Node2D

export var probability = 0.5
onready var BarR = load("res://Scenes/RedBar.tscn")
onready var BarG = load("res://Scenes/GreenBar.tscn")

func _ready():
	randomize()




func _on_Clearer_timeout():
	if randf() < probability:
		var m = BarG.instance()
		add_child(m)
	if randf() > probability:
		var m = BarR.instance()
		add_child(m)

