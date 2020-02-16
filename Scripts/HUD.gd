extends Node2D


func _ready():
	pass


func _on_Player_lives_changed():
	var l = get_node("/root/Game/Player").lives
	$Lives.text = "Lives: " +  str(l)


func _on_Player_score_changed():
	var s = get_node("/root/Game/Player").score
	$Score.text = "Score: " +  str(s)
