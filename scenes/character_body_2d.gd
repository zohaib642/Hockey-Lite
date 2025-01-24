extends CharacterBody2D

var speed = 17
var motion = Vector2.ZERO

func get_input():
	if !(position.x < 690):
		speed = 0
		position.x = position.x - 3
	elif (position.x < 285 && (position.y > 870 && position.y < 990)):
		speed = 0
		position.x = position.x + 3
	else:
		speed = 17
	var input_dir = Vector2(
		Input.get_action_strength("pk1right") - Input.get_action_strength("pk1left"),
		Input.get_action_strength("pk1down") - Input.get_action_strength("pk1up")
	)
	motion = input_dir.normalized() * speed

func _physics_process(delta):
	get_input()
	move_and_collide(motion)
	
