extends Spatial


func _ready():
	var partsProperties = get_parts()
	for i in partsProperties:
		var part = load("res://Scenes/Brick.tscn")
		var partInstance = part.instance()
		partInstance.set_translation(i[0])
		partInstance.set_scale(i[1])
		var colorMaterial = SpatialMaterial.new()
		if i[2] == "red":
			colorMaterial.albedo_color = Color.red
		elif i[2] == "green":
			colorMaterial.albedo_color = Color.green
		elif i[2] == "blue":
			colorMaterial.albedo_color = Color.blue
		elif i[2] == "yellow":
			colorMaterial.albedo_color = Color.yellow
		partInstance.get_node("BrickMesh").material_override = colorMaterial
		add_child(partInstance)


func get_parts():
	var properties = []
	var parser = XMLParser.new()
	var file = parser.open(GlobalVars.levelName)
	if (file != OK):
		print("Oops, something happened!")
		return
	while true:
		if parser.read() != OK:
			return properties
		if parser.get_node_type() == parser.NODE_ELEMENT and parser.get_node_name() == "part":
			var position = parser.get_named_attribute_value_safe("position")
			var positionArr = position.split(",", false)
			var positionVec = Vector3(float(positionArr[0]), float(positionArr[1]), float(positionArr[2]))
			var scale1 = parser.get_named_attribute_value_safe("scale")
			var scaleArr = scale1.split(",", false)
			var scaleVec = Vector3(float(scaleArr[0]), float(scaleArr[1]), float(scaleArr[2]))
			var color = parser.get_named_attribute_value_safe("color")
			var partProperties = [positionVec, scaleVec, color]
			properties.append(partProperties)
