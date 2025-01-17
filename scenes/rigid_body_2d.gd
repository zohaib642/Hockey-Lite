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

func _integrate_forces(state):
	
	if linear_velocity != Vector2.ZERO:
		linear_velocity = linear_velocity.normalized() * speed
	
	for i in state.get_contact_count():
		var collider = state.get_contact_collider_object(i)
		var normal = state.get_contact_local_normal(i)
		
		if collider.is_in_group("paddles"):
			var reflection = linear_velocity.reflect(normal)
			var paddle_influence = collider.velocity.normalized() * (speed * 0.5)
			linear_velocity = (reflection + paddle_influence).normalized() * speed
			
		elif collider.get_parent().name == "Border":
			linear_velocity = linear_velocity.reflect(normal)

	if (position.x > 500 && (position.y > -60 && position.y < 60)):
		reset_puck()
	if (position.x < -500 && (position.y > -60 && position.y < 60)):
		reset_puck()

func reset_puck():
	position.x = 0
	position.y = 0
	start_puck()
