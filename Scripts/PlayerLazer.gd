extends Node2D

var ready = true
onready var default_timer = $PT.wait_time

func _ready():
	pass

func fire(b):
	if ready:
		add_child(b)
		ready = false
		$PT.start()

func _on_PT_timeout():
	ready = true
