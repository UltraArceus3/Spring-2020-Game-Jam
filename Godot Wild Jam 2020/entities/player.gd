extends KinematicBody2D

var playerColor = [
	{ #MAIN
		"main": Color(0,0,0)
	},
	{ #CORE
		"core": Color(0,0,0)
	},
	{ #WING1
		"wing1": Color(0,0,0)
	},
	{ #WING2
		"wing2": Color(0,0,0)
	}
	
]

var bod

var angleMouse = round(get_angle_to(get_global_mouse_position()))
var aim_speed = deg2rad(10)
var direction
var velo = Vector2.ZERO

export var ShaftBody = 0

var bullet = preload("res://entities/Bullet.tscn")

export var acceleration = 5

export var playerControl = false
export var playerInfluenced = false

var canShoot = true

var attackPlayer = false

var health = 100

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if playerControl:
		playerColor = Global.playerColor
		playerInfluenced = false
	
	if !playerControl:
		playerColor[0].main = randomColor()
		$ShootTimeout.wait_time = 1
		
	randomize()
	position.x = randi()% 25000
	randomize()
	position.y = randi()% 25000
		


func _physics_process(delta: float) -> void:
	var get_playerControl = get_parent().get_parent().get_node("arrow").get_playerControl()



	print(Engine.get_frames_per_second())
	#print(position)
	$ShaftCol.scale = $Shaft.get_child(ShaftBody).get_child(2).scale


	$Shaft/shaft0/colorPixel.color = playerColor[1].core
	$wing0/wing0/colorPixel.color = playerColor[2].wing1
	$wing1/wing0/colorPixel.color = playerColor[3].wing2

	if playerColor[1].core == Color(0,0,0):
		$Shaft/shaft0/colorPixel.color = playerColor[0].main
	if playerColor[2].wing1 == Color(0,0,0):
		$wing0/wing0/colorPixel.color = playerColor[0].main
	if playerColor[3].wing2 == Color(0,0,0):
		$wing1/wing0/colorPixel.color = playerColor[0].main

	if health < 1:
		if !playerControl:
			if !playerInfluenced:
				playerInfluenced = true
				health = 100
				attackPlayer = false

			if playerInfluenced and health < 1:
				playerInfluenced = false
				health = 100
				attackPlayer = false

		$Area2D.scale = Vector2.ZERO
		$collisionReload.start()


	if playerControl:
		playerColor = Global.playerColor
		playerInfluenced = false
		
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
		if !attackPlayer:
			direction = ($position_calc.position - position).normalized()
			velo = direction*100
			move_and_slide(velo)
			
			
			
		if playerInfluenced:
			playerColor = Global.playerColor
			set_collision_mask(0)
			if name[0] != "I":
				randomize()
				set_name("Influenced" + str(randi()% 10000000))
		if !playerInfluenced:
			set_collision_mask(2)
			if name[0] != "E":
				randomize()
				set_name("Enemy" + str(randi()% 10000000))
		$Camera2D.current = false
		
		
		if attackPlayer:
			var i
			if !playerControl and !playerInfluenced:
				i = get_playerControl
				
				if !i.playerControl:
					attackPlayer = false

			if !playerControl and playerInfluenced and bod != null:
				print("bod:" + str(bod))
				i = get_parent().get_node(bod)
				
				if i == null:
					attackPlayer = false
				
			if i != null:
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
		if !playerControl and !playerInfluenced:
			i.enemy()
		i.shooterColor = playerColor
		i.shooterVol = velo
		i.shooterPos = position
		if playerColor[1].core == Color(0,0,0):
			i.color = playerColor[0].main
		else:
			i.color = playerColor[1].core
		i.rotation = rotation
		i.position = $position_calc.global_position
		get_parent().get_parent().add_child(i)
		canShoot = false
		$ShootTimeout.start()


func _on_Area2D_body_entered(body: Node):
	if !playerControl and !playerInfluenced:
		if body.name == "Player":
			attackPlayer = true
	
	if !playerControl and playerInfluenced:
		if body.name[0] == "E":
			bod = store(body.name)
			print("bod: " + bod)
			attackPlayer = true


func _on_Area2D_body_exited(body: Node) -> void:
	if !playerControl and !playerInfluenced:
		if body.name == "Player":
			attackPlayer = false
			
	if !playerControl and playerInfluenced:
		if body.name[0] == "E":
			attackPlayer = false

func randomColor():
	randomize()
	var red = randf()
	randomize()
	var blue = randf()
	randomize()
	var green = randf()
	return Color(red,blue,green)

func store(val):
	return val


func _on_collisionReload_timeout() -> void:
	$Area2D.scale = Vector2(1,1)


func _on_AI_Turn_timeout() -> void:
	randomize()
	$"AI Turn".wait_time = randi()% 30
	
	if !playerControl and !attackPlayer:
		randomize()
		rotation += (aim_speed/10)*stepify((randi()% 365) +deg2rad(90), 0.1)
	
	$"AI Turn".start()
