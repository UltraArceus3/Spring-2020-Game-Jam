extends Node2D


var entityAmount = 50
var entityCount = 3

var entity = preload("res://entities/player.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _physics_process(delta: float) -> void:
	while entityCount < entityAmount:
		var i = entity.instance()
		randomize()
		i.position.x = randi()% 25000
		randomize()
		i.position.y = randi()% 25000
		
		self.add_child(i)
		
		entityCount += 1
