extends Node

var save_dict = {}

var playerColor = [
	{ #MAIN
		"main": Color(1,0,0)
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



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
#	loadsave()
		#for i in playerColor:
			#var current_line = parse_json(color_sav.get_line())
			#playerColor[i] = 
		#print(playerColor)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("esc"):
		get_tree().quit()

#func save():
#	var save_dict = {
#		"color": playerColor
#	}
#	return save_dict

#func loadsave():
#	var color_sav = File.new()
#	if not color_sav.file_exists("user://color.save"):
#		return
#	else:
#		print(playerColor)
#		
#		color_sav.open("user://color.save", File.READ)
#		
#		save_dict = parse_json(color_sav.get_line())
#		print(Color(save_dict.color[2].wing1))
#		playerColor[0].main = Color(save_dict.color[0].main)
#		playerColor[1].core = Color(save_dict.color[1].core)
#		playerColor[2].wing1 = Color(save_dict.color[2].wing1)
#		playerColor[3].wing2 = Color(save_dict.color[3].wing2)
#		
#		color_sav.close()
