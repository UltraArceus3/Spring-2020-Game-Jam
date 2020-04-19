extends KinematicBody2D



var vol = Vector2.ZERO
export var speed = 200
var rot = 0
var shooterPos = Vector2.ZERO
var shooterVol = Vector2.ZERO

var color = Color(-1,-1,-1)

var passedColor = Color(0,0,0)
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	
	if color == Color(-1,-1,-1):
		color = passedColor
	modulate = color
	vol = ((position - shooterPos).normalized()  * 5000)
	move_and_slide(vol)
	pass
	


func _on_destroyTime_timeout() -> void:
	queue_free()
