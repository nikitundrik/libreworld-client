extends Spatial


func _ready():
	var partsPositions = get_parts()
	for i in partsPositions:
		var part = load("res://Scenes/Brick.tscn")
		var partInstance = part.instance()
		partInstance.set_translation(i)
		add_child(partInstance)


func get_parts():
	var partsPositions = []
	var parser = XMLParser.new()
	var file = parser.open(GlobalVars.levelName)
	if (file != OK):
		print("Oops, something happened!")
		return
	while true:
		if parser.read() != OK:
			return partsPositions
		if parser.get_node_type() == parser.NODE_ELEMENT and parser.get_node_name() == "part":
			var position = parser.get_named_attribute_value_safe("position")
			var positionArr = position.split(",", false)
			var positionVec = Vector3(float(positionArr[0]), float(positionArr[1]), float(positionArr[2]))
			partsPositions.append(positionVec)
