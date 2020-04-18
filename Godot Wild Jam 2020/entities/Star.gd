extends Sprite


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var red = 1
var blue = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func back():
	scale = Vector2(1,1)
	modulate = Color(1, 1, 1, 0.3)
	
	
func mid():
	color()
	scale = Vector2(3,3)
	modulate = Color(red, blue, 1, 0.7)
	
func front():
	color()
	scale = Vector2(6,6)
	modulate = Color(red, blue, 1, 1)
	

func color():
	pass
	#randomize()
	#red = randf()
	#randomize()
	#blue = randf()
