extends Area2D

var rnd_number

var Sword = false
var Staff = false
var Key = false

export var key_only = false
export var sword_only = false
export var staff_only = false

func _ready():
	if sword_only == true:
		$Sword/Sprite.frame = 932
		Sword = true
	if staff_only == true:
		$Sword/Sprite.frame = 865
		Staff = true
	if key_only == true:
		$Sword/Sprite.frame = 752
		Key = true

func _on_Collection_body_entered(body):
	if body.name == "Player":
		if Staff == true:
			body.item_visible = true
			body.Staff = true
			body.Sword = false
			body.Key = false
		if Sword == true:
			body.item_visible = true
			body.Staff = false
			body.Sword = true
			body.Key = false
		if Key == true:
			body.item_visible = true
			body.Key = true
			body.Staff = false
			body.Sword = false
	queue_free()
