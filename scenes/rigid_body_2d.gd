extends RigidBody2D

@export var speed = 800.0

var physics_material = PhysicsMaterial.new()

func _ready():
	gravity_scale = 0.0
	linear_damp = 0
	angular_damp = 1
	physics_material.friction = 0.0
	physics_material.bounce = 1.0
	physics_material_override = physics_material
	
	start_puck()

func start_puck():
	var angle = randf_range(0, 2 * PI)
	linear_velocity = Vector2(cos(angle), sin(angle)) * speed

func _integrate_forces(_state):
	# Maintain constant speed
	if linear_velocity.length() != 0:
		linear_velocity = linear_velocity.normalized() * speed
		
	if position.x > 540 and abs(position.y) < 60:
		Global.scoreBlue += 1
		reset_puck()
		if Global.scoreBlue == 7:
			winner("blue")
	elif position.x < -540 and abs(position.y) < 60:
		Global.scoreOrange += 1
		reset_puck()
		if Global.scoreOrange == 7:
			winner("orange")
			

func winner(winnerName):
	if winnerName == "orange":
		print("Orange wins!")
	elif winnerName == "blue":
		print("Blue wins!")

func reset_puck():
	position.x = 0
	position.y = 0
	start_puck()
