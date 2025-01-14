extends CharacterBody2D

var speed = 50
var motion = Vector2.ZERO

func get_input():
	var input_dir = Vector2(
		Input.get_action_strength("pk1right") - Input.get_action_strength("pk1left"),
		Input.get_action_strength("pk1down") - Input.get_action_strength("pk1up")
	)
	motion = input_dir.normalized() * speed

func _physics_process(delta):
	get_input()
	move_and_collide(motion)
