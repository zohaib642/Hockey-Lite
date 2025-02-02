extends RigidBody2D

@export var speed = 800.0
@export var character_to_sound_map: Dictionary = {}

var physics_material = PhysicsMaterial.new()

func _ready():
	
	gravity_scale = 0.0
	linear_damp = 0
	angular_damp = 1
	physics_material.friction = 0.0
	physics_material.bounce = 1.0
	physics_material_override = physics_material
	body_entered.connect(_on_body_entered)
	
	start_puck()

func start_puck():
	
	var angle = randf_range(0, 2 * PI)
	linear_velocity = Vector2(cos(angle), sin(angle)) * speed

func _integrate_forces(_state):
	if linear_velocity.length() != 0:
		linear_velocity = linear_velocity.normalized() * speed
		
	if position.x > 540 and abs(position.y) < 65:
		Global.scoreBlue += 1
		$goalsound.play()
		if Global.scoreBlue == Global.winningScore:
			winner("blue")
		else:
			reset_puck()
	elif position.x < -540 and abs(position.y) < 65:
		Global.scoreOrange += 1
		$goalsound.play()
		if Global.scoreOrange == Global.winningScore:
			winner("orange")	
		else:
			reset_puck()

func winner(winnerName):
	if winnerName == "orange":
		get_tree().change_scene_to_file("res://scenes/game_overO.tscn")
	elif winnerName == "blue":
		get_tree().change_scene_to_file("res://scenes/game_overB.tscn")

func reset_puck():
	position.x = 0
	position.y = 0
	
	start_puck()

func _on_body_entered(body: Node):
	# Check if the colliding body is a paddle
	if body.is_in_group("paddles"):
		$pucksound.pitch_scale = randf_range(0.95, 1.05)
		$pucksound.play()  # Play the sound
