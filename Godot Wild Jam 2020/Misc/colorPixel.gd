extends Sprite


export var color = Color(-1,-1,-1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	if get_tree().get_current_scene().get_name() == "World":
		if color == Color(-1,-1,-1):
			color = get_parent().get_parent().get_parent().playerColor
	self.modulate = color
