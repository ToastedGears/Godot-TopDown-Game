extends Node2D

var remaining_gates = 4

var end = false

func _on_Pressureplate_One_Down():
	remaining_gates -= 1
	match remaining_gates:
		3:
			$Security/Fence.open()
		2:
			$Security/Fence2.open()
		1:
			$Security/Fence3.open()

# warning-ignore:unused_argument
func _input(event):
	if end == true:
		if Input.is_action_pressed("Esc"):
			get_tree().quit()


func _on_Exit_body_entered(body):
	if body.name == "Player":
		body.cinematic = true
		body.anim.play("Walk")
		body.velocity.y = 100
		yield(get_tree().create_timer(3),"timeout")
		$RichTextLabel2.visible = true
		$RichTextLabel3.visible = true
		end = true
