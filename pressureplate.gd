extends Area2D

signal stepped_on
signal stepped_off
signal One_Down

var used = false
export var end = false
var usage = 1


export var open = false

func _ready():
	if open == false:
		self.modulate = Color(1,0,0,1)
	if open == true:
		self.modulate = Color(0,1,0,1)

func _on_Pressureplate_body_entered(body):
	if body.name == "Player":
		if used == false:
			emit_signal("stepped_on")
			$Sprite.frame = 322
			used = true
			yield(get_tree().create_timer(1),"timeout")
			$Sprite.frame = 321
		elif used == true:
			emit_signal("stepped_off")
			$Sprite.frame = 322
			used = false
			yield(get_tree().create_timer(1),"timeout")
			$Sprite.frame = 321
		if end == true:
			if usage == 1:
				usage -= 1
				emit_signal("One_Down")
