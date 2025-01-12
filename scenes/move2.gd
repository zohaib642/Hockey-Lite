extends Sprite2D

var speed = 2000
# Called when the node enters the scene tree for the first time.

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("sprite2_right") or Input.is_key_pressed(KEY_RIGHT):
		position.x += speed * delta
	if Input.is_action_pressed("sprite2_left") or Input.is_key_pressed(KEY_LEFT):
		if position.x > get_tree().root.get_viewport().get_size().x/2.1:
			position.x -= speed * delta
	if Input.is_action_pressed("sprite2_up") or Input.is_key_pressed(KEY_UP):
		position.y -= speed * delta
	if Input.is_action_pressed("sprite2_down") or Input.is_key_pressed(KEY_DOWN):
		position.y += speed * delta
		
