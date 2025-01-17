extends RigidBody2D

@export var speed = 600.0

# Create a physics material with no friction
var physics_material = PhysicsMaterial.new()

func _ready():
	# Essential physics setup
	gravity_scale = 0.0
	linear_damp = 0
	angular_damp = 1
	physics_material.friction = 0.0
	physics_material.bounce = 1.0
	physics_material_override = physics_material
	
	# Start the puck moving
	start_puck()

func start_puck():
	# Random starting direction
	var angle = randf_range(0, 2 * PI)
	linear_velocity = Vector2(cos(angle), sin(angle)) * speed

func _integrate_forces(state):
	# This is called during physics processing
	
	# Force constant speed
	if linear_velocity != Vector2.ZERO:
		linear_velocity = linear_velocity.normalized() * speed
	
	# Get collision count
	for i in state.get_contact_count():
		var collider = state.get_contact_collider_object(i)
		var normal = state.get_contact_local_normal(i)
		
		if collider.is_in_group("paddles"):
			# Paddle hit - reflect based on normal and add paddle velocity
			var reflection = linear_velocity.reflect(normal)
			var paddle_influence = collider.velocity.normalized() * (speed * 0.5)
			linear_velocity = (reflection + paddle_influence).normalized() * speed
			
		elif collider.get_parent().name == "Border":
			# Wall hit - simple angle reflection
			linear_velocity = linear_velocity.reflect(normal)

func reset_puck():
	# Reset position and start moving
	position = get_viewport_rect().size / 2
	start_puck()
