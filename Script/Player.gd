extends KinematicBody2D


const SPEED = 200
const JUMPOWER = -400

var velocity = Vector2.ZERO
var GRAVITY = 9.8 * 5
var on_rope = null
var on_portal_button = null
var on_portal = null
var portal_active = false

signal portal_on
signal exit_lvl

func _physics_process(_delta):
	velocity.y += GRAVITY
	
	
	if on_rope != null:
		GRAVITY = 0
		if Input.is_action_pressed("ui_down"):
			velocity.y = SPEED/2
			$player.animation = "Climb"
		elif Input.is_action_pressed("ui_up"):
			velocity.y = -SPEED/2
			$player.animation = "Climb"
		else:
			$player.animation = "IdleC"
			velocity.y = 0
		if Input.is_action_pressed("ui_right"):
			velocity.x = SPEED
			$player.flip_h = true
		if Input.is_action_pressed("ui_left"):
			velocity.x = -SPEED
			$player.flip_h = false
	else:
		GRAVITY = 30
		if Input.is_action_pressed("ui_right"):
			velocity.x = SPEED
			$player.animation = "Walk"
			$player.flip_h = false
		elif Input.is_action_pressed("ui_left"):
			velocity.x = -SPEED
			$player.animation = "Walk"
			$player.flip_h = true
		elif is_on_floor() and ($player.animation != "Activate" or  $player.is_playing() == false):
			$player.animation = "Idle"
		if Input.is_action_just_pressed("ui_up") and is_on_floor():
			velocity.y = JUMPOWER
		if not is_on_floor():
			$player.animation = "Air"
	
	if on_portal_button != null:
		if Input.is_action_pressed("ui_interact"):
			emit_signal("portal_on")
			$player.animation = "Activate"
			portal_active = true
	
	if on_portal != null and portal_active:
		emit_signal("exit_lvl")
	
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	velocity.x = lerp(velocity.x, 0, 0.2)


func _on_Rope_area_entered(area):
	if (area.is_in_group("ROPE")):
		on_rope = area



func _on_Rope_area_exited(area):
	if (area.is_in_group("ROPE") and on_rope == area):
		on_rope = null



func _on_Trigger_detection_area_entered(area):
	if (area.is_in_group("PORTAL_BUTTON")):
		on_portal_button = area
	print("b",area)


func _on_Trigger_detection_area_exited(area):
	if (area.is_in_group("PORTAL_BUTTON") and on_portal_button == area):
		on_portal_button = null
	print("b2",area)


func _on_Portal_detection_area_exited(area):
	if (area.is_in_group("PORTAL") and on_portal == area):
		on_portal = null
	print("p",area)


func _on_Portal_detection_area_entered(area):
	if area.is_in_group("PORTAL") :
		on_portal = area
	print("p2",area)

