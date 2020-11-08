extends Node2D

var Security_Level = 3

func _on_Exit_Next_Floor():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Outside.tscn")


func _on_Pressureplate_stepped_on():
	$Security/Fence5.close()
	$Security/Fence6.close()
	$Security/Fence7.close()
	$Security/Fence8.close()
	$PressurePlate/RichTextLabel.visible = true
	yield(get_tree().create_timer(3),"timeout")
	$PressurePlate/RichTextLabel.visible = false


func _on_Enemy_killed():
	Security_Level -= 1
	if Security_Level == 0:
		$Gates/Fence.open()
		$Gates/Fence5.open()


func _on_Open_stepped_on():
	$Security/Fence5.open()
	$Security/Fence6.open()
	$Security/Fence7.open()
	$Security/Fence8.open()
