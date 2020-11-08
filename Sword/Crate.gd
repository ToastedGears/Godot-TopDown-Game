extends StaticBody2D

var Sword = false

func _on_SwordAccept_body_entered(body):
	if body.name == "Player":
		if body.Sword == true:
			body.item_visible = false
			body.Sword = false
			queue_free()
