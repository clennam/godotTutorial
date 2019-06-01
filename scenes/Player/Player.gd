extends Area2D

signal hit

export var speed = 400	#How fast the player will move (pixels/second)
var screen_size	#size of the game window

func _ready():
	screen_size = get_viewport_rect().size
	hide()
	
func _process(delta):
	var velocity = Vector2()	#the player's movement vector
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed	#normalise speed so that diag. movement is not faster than hoz. and vert.
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	position += velocity * delta	#update position based on velocity over delta(time)
	position.x = clamp(position.x, 0, screen_size.x)	#limit movement so that object does not leave the screen
	position.y = clamp(position.y, 0, screen_size.y)
	if velocity.x != 0:	#set correct hoz. animations
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:	#set correct vert. animations
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0

func _on_Player_body_entered(body):
	hide() #make the player disappear after being hit
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false