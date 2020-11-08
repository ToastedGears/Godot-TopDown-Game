extends KinematicBody2D

const BASE_MOVE_SPEED = 6 * 16
const BASE_MOVE_WEIGHT = 0.1

onready var anim = $AnimationPlayer

var velocity = Vector2.ZERO
var move_direction = Vector2.ZERO
var desired_velocity = Vector2.ZERO

onready var weapon_position = $WeaponPosition
onready var weapon_distance = weapon_position.position.length()

export var Sword = false
export var Staff = false
export var Key = false
var item_visible = false

var cinematic = false

func _ready():
	get_tree().call_group("Enemy", "set_player", self)
	$WeaponPosition/Sword/Sprite.visible = false

# warning-ignore:unused_argument
func _physics_process(delta):
	if cinematic == false:
		_handle_input()
		_move_weapon()
		_change_weapon()
		_check_visibility()
	_apply_movement()

func _check_visibility():
	if item_visible == false:
		$WeaponPosition/Sword/Sprite.visible = false
	if item_visible == true:
		$WeaponPosition/Sword/Sprite.visible = true

func _handle_input():
	move_direction = Vector2.ZERO
	move_direction.x = -int(Input.is_action_pressed("Left")) + int(Input.is_action_pressed("Right"))
	move_direction.y = -int(Input.is_action_pressed("Up")) + int(Input.is_action_pressed("Down"))
	
	desired_velocity = move_direction.normalized() * BASE_MOVE_SPEED
	if Input.is_action_pressed("Right") or Input.is_action_pressed("Left") or Input.is_action_pressed("Up") or Input.is_action_pressed("Down"): 
		$AnimationPlayer.play("Walk")
	else:
		$AnimationPlayer.play("Stand")
	
	if Input.is_action_pressed("Reload"):
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()

func _move_weapon():
	var angle = get_local_mouse_position().angle()
	weapon_position.position.x = cos(angle) * weapon_distance
	weapon_position.position.y = sin(angle) * weapon_distance
	weapon_position.rotation = angle

func _apply_movement():
	velocity = velocity.linear_interpolate(desired_velocity, BASE_MOVE_WEIGHT)
	velocity = move_and_slide(velocity)

func _change_weapon():
	if Sword == true:
		$WeaponPosition/Sword/Sprite.rotation_degrees = 45
		$WeaponPosition/Sword/Sprite.frame = 932
		$Sprite.frame = 25
	if Staff == true:
		$WeaponPosition/Sword/Sprite.rotation_degrees = 45
		$WeaponPosition/Sword/Sprite.frame = 865
		$Sprite.frame = 248
	if Key == true:
		$WeaponPosition/Sword/Sprite.rotation_degrees = 0
		$WeaponPosition/Sword/Sprite.frame = 752
		$Sprite.frame = 25
