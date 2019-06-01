extends RigidBody2D

export var min_speed = 150	#Minimum Speed Range
export var max_speed = 250	#Maximum Speed Range
var mob_types = ["walk", "swim", "fly"]	#3 types of enemies (animations)

func _ready():
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]

func _on_Visibility_screen_exited():
	queue_free()

func on_start_game():
	queue_free()