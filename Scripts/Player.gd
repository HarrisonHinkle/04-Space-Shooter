extends KinematicBody2D

export var health = 1
export var score = 0
export var margin = 25
export var y_range = 600
export var acceleration = 0.1
export var lives = 3 

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
	emit_signal("health_changed")
	if health <= 0:
		die()

func change_score(s):
	score += s
	emit_signal("score_changed")		

func die():
	lives = lives - 1 
	if lives == 0:
		pass

func _physics_process(delta):
	if Input.is_action_pressed("fire"):
		var b = PLazer.instance()
		b.position = position
		b.position.y -= 25
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
		$AnimatedSprite.play("transform")
	else:
		$AnimatedSprite.stop()
