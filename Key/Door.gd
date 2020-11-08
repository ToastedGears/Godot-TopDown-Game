extends StaticBody2D

var Key = false

func _on_KeyAccept_body_entered(body):
	if body.name == "Player":
		if body.Key == true:
			$Sprite.frame += 2
			call_deferred("_Delete_Collision")
			body.item_visible = false
			body.Key = false

func _Delete_Collision():
	$KeyAccept/CollisionShape2D.disabled = true
	$CollisionShape2D.disabled = true
