extends RigidBody2D

var velocity = Vector2(0,0)
export var min_speed = 100
export var max_speed = 300
export var damage = 1

onready var Explosion = load("res://Scenes/Explosion.tscn")

func _ready():
	randomize()
	position.x = 515.745
	position.y = -20
	velocity.y = max(randi() % max_speed, min_speed)
	contact_monitor = true
	set_max_contacts_reported(4)
	linear_velocity = velocity


func _physics_process(delta):
	var colliding = get_colliding_bodies()
	for c in colliding:
		if c.name == "Player":
			var explosion = Explosion.instance()
			explosion.position = position
			explosion.get_node("Sprite").playing = true
			get_node("/root/Game/Explosions").add_child(explosion)
			c.change_health(-damage)
		queue_free()
