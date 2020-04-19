extends KinematicBody2D

var playerColor = Color(1,0,0)

var angleMouse = round(get_angle_to(get_global_mouse_position()))
var aim_speed = deg2rad(10)
var direction
var velo = Vector2.ZERO

export var ShaftBody = 0

var bullet = preload("res://entities/Bullet.tscn")

export var acceleration = 5

export var playerControl = false

var canShoot = true

var attackPlayer = false



# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		
	if !playerControl:
		playerColor = randomColor()
		$ShootTimeout.wait_time = 1
		


func _physics_process(delta: float) -> void:
	var get_playerControl = get_parent().get_parent().get_node("arrow").get_playerControl()

	#print(Engine.get_frames_per_second())
	print(position)
	$ShaftCol.scale = $Shaft.get_child(ShaftBody).get_child(2).scale

	if playerControl:
		$Camera2D.current = true
		set_name("Player")
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
			shoot()
		
		if Input.is_action_pressed("STOP"):
			velo = Vector2.ZERO

	if !playerControl:
		$Camera2D.current = false
		if name == "Player":
			randomize()
			set_name("Enemy" + str(randi()% 10000000))
		
		if attackPlayer:
			var i = get_playerControl
			rotation += (aim_speed/10)*stepify(get_angle_to(i.position)+deg2rad(90), 0.1)
			shoot()
			direction = (i.position - position).normalized()
			if abs((i.position - position).length()) > 200:
				velo = direction*100
				move_and_slide(velo)


func _on_ShootTimeout_timeout() -> void:
	canShoot = true


func shoot():
	if canShoot:
		var i = bullet.instance()
		i.shooterVol = velo
		i.shooterPos = position
		i.passedColor = playerColor
		i.rotation = rotation
		i.position = $position_calc.global_position
		get_parent().get_parent().add_child(i)
		canShoot = false
		$ShootTimeout.start()


func _on_Area2D_body_entered(body: Node) -> void:
	if body.name == "Player":
		attackPlayer = true


func _on_Area2D_body_exited(body: Node) -> void:
	if body.name == "Player":
		attackPlayer = false

func randomColor():
	randomize()
	var red = randf()
	randomize()
	var blue = randf()
	randomize()
	var green = randf()
	return Color(red,blue,green)
