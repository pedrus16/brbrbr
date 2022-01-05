extends Node

onready var connect_dialog = $ConnectDialog
onready var game = $Game


func _ready():
	connect_dialog.popup()
