extends Node2D


export var starCount = {
		"backCount": 10000,
		"midCount": 500,
		"frontCount": 100
}

var starCurrent = {
	"backCount": 0,
	"midCount": 0,
	"frontCount": 0
}

var star = preload("res://entities/Star.tscn")

var i


func _ready() -> void:
	pass


	#starBack.modulate = Color(1, 1, 1, 0.3)
	#starMid.modulate = Color(1, 1, 1, 0.7)
	#starFront.modulate = Color(1, 1, 1, 1)

func random_coordinates(xlimit, ylimit, xstart = 0, ystart = 0):
	randomize()
	var x = randi() % xlimit + xstart
	randomize()
	var y = randi() % ylimit + ystart
	
	return Vector2(x,y)

func _process(delta):
	
	var starBack = get_child(1).get_child(0)
	var starMid = get_child(2).get_child(0)
	var starFront = get_child(3).get_child(0)
	
	while starCurrent.backCount < starCount.backCount:
		i = star.instance()
		i.back()
		randomize()
		i.position = random_coordinates(10000, 10000, -100, -100)
		starBack.add_child(i)
		
		#print(starCurrent.backCount)
		
		starCurrent.backCount += 1

	while starCurrent.midCount < starCount.midCount:
		i = star.instance()
		i.mid()
		randomize()
		i.position = random_coordinates(10000, 10000, -100, -100)
		starMid.add_child(i)
		
		print(starCurrent.midCount)
		
		starCurrent.midCount += 1

	while starCurrent.frontCount < starCount.frontCount:
		i = star.instance()
		i.front()
		randomize()
		i.position = random_coordinates(10000, 10000, -100, -100)
		starFront.add_child(i)
		
		print(starCurrent.frontCount)
		

		
		starCurrent.frontCount += 1
		
	get_parent().get_node("TextureRect").visible = false
