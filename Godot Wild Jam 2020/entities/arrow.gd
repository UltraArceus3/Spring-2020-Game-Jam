extends Sprite


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var player = get_playerControl()

	position = player.position + ((player.velo).normalized()*100)
	rotation += get_angle_to(player.position) + deg2rad(-90)

func get_playerControl():
	for i in get_parent().get_node("Entities").get_children():
		if i.playerControl:
			return i
	return null
