extends Node2D


var relative_pos

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
	
func _physics_process(delta: float) -> void:
	relative_pos = get_parent().get_angle_to(position)
