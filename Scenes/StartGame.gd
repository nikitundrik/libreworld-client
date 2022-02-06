extends Control

onready var sceneEdit: LineEdit = get_node("VBoxContainer/SceneEdit")


func _on_StartButton_button_down():
	GlobalVars.levelName = sceneEdit.text
	get_tree().change_scene("res://Scenes/LevelScene.tscn")
