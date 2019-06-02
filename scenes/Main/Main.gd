extends Node

export (PackedScene) var Mob
var score

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()

func new_game():
	score = 0
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$Music.play()

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_MobTimer_timeout():
	#Choose a random location on MobPath
	$MobPath/MobSpawnLocation.set_offset(randi())
	#Create a Mob and add it to the scene
	var mob = Mob.instance()
	add_child(mob)
	#Set the mob's position to the current location of MobSpawnLocation, which moves around MobPath continuously
	mob.position = $MobPath/MobSpawnLocation.position
	#Set the mob's direction perpendicular to MobPath, with some randomness
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	#Set speed
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	#Set direction
	mob.linear_velocity = mob.linear_velocity.rotated(direction)
	$HUD.connect("start_game", mob, "on_start_game")