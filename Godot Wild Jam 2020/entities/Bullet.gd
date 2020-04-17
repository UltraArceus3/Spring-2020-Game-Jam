extends KinematicBody2D



var vol = Vector2.ZERO
export var speed = 200
var rot = 0
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	#move_and_collide()
	if rotation != rot:
		rotation = rot
