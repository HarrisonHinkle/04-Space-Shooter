extends KinematicBody2D

export var health = 1
export var score = 0
export var margin = 25
export var y_range = 600
export var acceleration = 0.1
export var lives = 5
export var ship ="GREEN"
var velocity = Vector2(0,0)

onready var VP = get_viewport_rect().size

onready var PLazer = load("res://Scenes/PlayerLazer_H.tscn")

signal lives_changed
signal score_changed

func _ready():
	emit_signal("lives_changed")
	emit_signal("score_changed")

func change_health(h):
	health += h
	if health <= 0:
		die()

func change_score(s):
	score += s
	emit_signal("score_changed")		

func die():
	lives = lives - 1 
	emit_signal("lives_changed")
	if lives == 0:
		get_tree().change_scene("res://Scenes/Game Over.tscn")

func _physics_process(delta):
	if Input.is_action_pressed("fire"):
		var b = PLazer.instance()
		b.position = position
		b.position.y -= 20
		get_node("/root/Game/PlayerLazer").fire(b)
	if Input.is_action_pressed("left"):
		position.x = position.x - 10
	if Input.is_action_pressed("right"):
		position.x = position.x + 10
	if Input.is_action_pressed("up"):
		position.y = position.y + -10
	if Input.is_action_pressed("down"):
		position.y = position.y + 10


	if position.x < margin:
		velocity.x = 0
		position.x = margin
	if position.x > VP.x - margin:
		velocity.x = 0
		position.x = VP.x - margin
	if position.y < VP.y - y_range:
		velocity.y = 0
		position.y = VP.y - y_range
	if position.y > VP.y - margin:
		velocity.y = 0
		position.y = VP.y - margin

	var collision = move_and_collide(velocity)
	
func _process(delta):
	if Input.is_action_pressed("switch"):
		if ship == "GREEN":
			$CGREEN.play("transform")
		if ship == "RED":
			$CRED.play("transform")
		


func _on_Timer_timeout():
	pass # Replace with function body.


func _on_CRED_animation_finished():
	$CGREEN.show()
	$CRED.stop()
	ship = "GREEN"
	set_collision_layer(8)
	set_collision_mask(5)
	

func _on_CGREEN_animation_finished():
	$CGREEN.hide()
	$CGREEN.stop()
	ship = "RED"
	set_collision_layer(7)
	set_collision_mask(2)
 
