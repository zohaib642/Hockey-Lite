extends CharacterBody2D

@export var initial_speed = 300.0
@export var min_speed = 50.0
@export var speed_increase_factor = 1.05

func _ready():
	velocity = Vector2(randf() * 2 - 1, randf() * 2 - 1).normalized() * initial_speed

func _physics_process(delta):
	move_and_slide()
	if get_slide_collision_count() > 0:
		for i in range(get_slide_collision_count()):
			var collision = get_slide_collision(i)
			handle_collision(collision)

func handle_collision(collision):
	if collision == null:
		return
	var normal = collision.get_normal()
	velocity = velocity.bounce(normal)
	if velocity.length() < min_speed:
		velocity = velocity.normalized() * min_speed
	velocity = velocity.normalized() * (velocity.length() * speed_increase_factor)
	position += normal * 1.0
