extends KinematicBody2D



var vol = Vector2.ZERO
export var speed = 200
var rot = 0
var shooterPos = Vector2.ZERO
var shooterVol = Vector2.ZERO

var damage = 5
var color = Color(-1,-1,-1)

var shooterColor

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	

	modulate = color
	vol = ((position - shooterPos).normalized()  * 100)
	var col = move_and_collide(vol)
	
	if col:
		print(col.collider.name)
		var i = get_parent().get_node("Entities/" + col.collider.name)

			
		i.health -= damage
		
		if i.playerInfluenced and i.health < 1:
			i.playerColor = shooterColor
			
		queue_free()

func _on_destroyTime_timeout() -> void:
	queue_free()
	
func enemy():
	set_collision_mask(0)
	damage = 10
