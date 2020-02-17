extends Node2D

export var probability = 0.5
onready var ShotG = load("res://Scenes/RedShot.tscn")
onready var ShotR = load("res://Scenes/GreenShot.tscn")

func _ready():
	randomize()


func _on_Timer_timeout():
	if randf() < probability:
		var m = ShotG.instance()
		add_child(m)
	if randf() > probability:
		var m = ShotR.instance()
		add_child(m)
