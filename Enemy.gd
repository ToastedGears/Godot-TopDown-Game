extends KinematicBody2D

signal killed

var Player = null
var dead = false
onready var weapon_position = $WeaponPosition
onready var weapon_distance = weapon_position.position.length()

var velocity = Vector2()
var speed = 60
export (NodePath) var patrol_path
var patrol_points
var patrol_index = 0

#StealthStuff
enum Stealth {Unseen, Suspicous, Spotted, Alert}
enum Type {Old, Young, Smart, Forgetful}

export(Stealth) var Status

func _ready():
	$AnimationPlayer.play("Walk")
	add_to_group("Enemy")
	patrol_points = get_node(patrol_path).curve.get_baked_points()
	$WeaponPosition/Sword/Sprite.frame = 936

# warning-ignore:unused_argument
func _physics_process(delta):
	if dead == false:
		if Player == null:
			return
		if Status == Stealth.Suspicous or Status == Stealth.Spotted or Status == Stealth.Alert:
			var vec_to_player = Player.global_position - global_position
			vec_to_player = vec_to_player.normalized()
			$WeaponPosition.global_rotation = atan2(vec_to_player.y, vec_to_player.x)
			
	# warning-ignore:return_value_discarded
			move_and_collide(vec_to_player * speed * delta)
		
		if Status == Stealth.Unseen:
			if !patrol_path:
				return
			var target = patrol_points[patrol_index]
			if position.distance_to(target) < 1:
				patrol_index = wrapi(patrol_index + 1, 0, patrol_points.size())
				target = patrol_points[patrol_index]
			velocity = (target - position).normalized() * speed
			velocity = move_and_slide(velocity)
		
		if Status == Stealth.Suspicous:
			speed = 50
		elif Status == Stealth.Spotted:
			speed = 70
		elif Status == Stealth.Alert:
			speed = 90
		elif Status == Stealth.Unseen:
			speed = 60

func set_player(p):
	Player = p

func _on_Suspicous_body_entered(body):
	if body.name == "Player":
		if body.Staff == false:
			Status = Stealth.Suspicous

func _on_Suspicous_body_exited(body):
	if Status != Stealth.Spotted:
		if body.name == "Player":
			Status = Stealth.Unseen

func _on_Detection_body_entered(body):
	if body.name == "Player":
		if body.Staff == false:
			Status = Stealth.Spotted

func _on_Arrested_body_entered(body):
	if body.name == "Player":
		if body.Sword == true:
			dead = true
			$AnimationPlayer.play("Death")
			yield($AnimationPlayer,"animation_finished")
			emit_signal("killed")
			body.item_visible = false
			body.Sword = false
			queue_free()
		else:
# warning-ignore:return_value_discarded
			get_tree().reload_current_scene()
