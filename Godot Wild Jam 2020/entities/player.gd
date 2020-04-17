extends KinematicBody2D

var angleMouse = round(get_angle_to(get_global_mouse_position()))
var aim_speed = deg2rad(10)
var direction
var velo = Vector2.ZERO

var bullet = preload("res://entities/Bullet.tscn")

export var acceleration = 5



# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	angleMouse = stepify(get_angle_to(get_global_mouse_position())+deg2rad(90), 0.1)
	
	direction = (get_global_mouse_position() - position).normalized()
	
	var col = move_and_collide(velo * delta)
	
	if col:
		velo /= 2
		velo = velo.bounce(col.normal)
	#print(col)
	#if is_on_ceiling() or is_on_floor():
		#velo.x = velo.x/2
		#velo.y = -velo.y/2
			
	#if is_on_wall():
		#velo.x = -velo.x/2
		#velo.y = velo.y/2
	
	#print((get_global_mouse_position() - position).length())
	
	#print(angleMouse)
	if angleMouse != 0:
		rotation += aim_speed*angleMouse


	if Input.is_action_pressed("forward"):
		if abs((get_global_mouse_position() - position).length()) > 3:
			velo += direction*acceleration
			
	if Input.is_action_pressed("schut"):
		var i = bullet.instance()
		i.rot = rotation
		i.position = $position_calc.global_position
		get_parent().add_child(i)

