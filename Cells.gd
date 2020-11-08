extends Node2D

var read_sword = false
var read_staff = false
var read_exit = false

func _ready():
	$Security/Fence17.close()

func _on_Exit_Next_Floor():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Catacombs.tscn")

func _on_Enemy_killed():
	$Security/Fence17.open()

func _on_Guard2_body_entered(body):
	if body.name == "Player":
		if read_exit == false:
			$Tutorial/TextExit.visible = true
			yield(get_tree().create_timer(3),"timeout")
			$Tutorial/TextExit.visible = false
			read_exit = true


func _on_Swords_body_entered(body):
	if body.name == "Player":
		if read_sword == false:
			$Tutorial/TextSword.visible = true
			yield(get_tree().create_timer(3),"timeout")
			$Tutorial/TextSword.visible = false
			read_sword = true


func _on_Staff_body_entered(body):
	if body.name == "Player":
		if read_staff == false:
			$Tutorial/TextStaff.visible = true
			yield(get_tree().create_timer(3),"timeout")
			$Tutorial/TextStaff.visible = false
			read_staff = true
