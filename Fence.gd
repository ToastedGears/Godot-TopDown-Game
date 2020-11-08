extends StaticBody2D

func _ready():
	if is_in_group("Security"):
		call_deferred("Hidden")

func Hidden():
	$CollisionShape2D.disabled = true
	$Sprite.visible = false

func close():
	call_deferred("Appear")

func open():
	call_deferred("Hidden")

func Appear():
	$CollisionShape2D.disabled = false
	$Sprite.visible = true
