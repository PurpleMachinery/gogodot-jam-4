extends Node
class_name Microprofile

@onready var microprofilePath = 'res://src/resources/META-INF/microprofile.properties';

func _ready():
	print(getProfile());

func getProfile():
	var configs = {};

	var file = FileAccess.open(microprofilePath, FileAccess.READ);

	while !file.eof_reached():
		var line = file.get_line()
		if(!line.is_empty()):
			var values = line.split("=")
			var key = values[0]
			var value = values[1];

			if(value.is_valid_int()):
				value = int(value)
			elif(value.is_valid_float()):
				value = float(value)
			elif(value == "true"):
				value = true
			elif(value == "false"):
				value = false
			

			configs[key] = value
	
	file.close();
	
	return configs;
