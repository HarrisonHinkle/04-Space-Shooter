extends Node2D

export var max_enemies = 3
export var probability = 0.3

onready var Green = load("res://Scenes/Red.tscn")
onready var Red = load("res://Scenes/Green.tscn")

func _ready():
	randomize()


func _on_ET_timeout():
	if get_child_count() < max_enemies + 1:
		if randf() < probability or get_child_count() == 1:
			if randf() < 0.5:
				var e = Green.instance()
				add_child(e)
			else:
				var e = Red.instance()
				add_child(e)
