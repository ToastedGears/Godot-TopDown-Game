extends Node2D

signal Next_Floor

func _on_Leav_body_entered(body):
	if body.name == "Player":
		emit_signal("Next_Floor")
