extends Panel

func _ready():
	var err = get_node("Button").connect("pressed", self, "_on_Button_pressed")
	if err == 0: pass


func _on_Button_pressed():
	get_node("Label").text = "Hello!"
	$SwitchSceneTimer.start()

func _on_SwitchSceneTimer_timeout():
	get_tree().change_scene("res://scenes/Main/Main.tscn")